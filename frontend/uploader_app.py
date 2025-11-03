import streamlit as st
import requests
import os

# --- Configuration ---
FASTAPI_ENDPOINT = "http://127.0.0.1:8000/api/v1/chapters/upload-and-process"

# --- Streamlit App ---
st.set_page_config(page_title="Scopes 🧑‍🏫", layout="wide")
st.title("Studious - Teacher Upload Portal 📝")
st.write("Upload a chapter PDF and set your parameters to generate learning materials.")

# --- Form for Upload ---
with st.form(key="upload_form"):
    
    # --- Input Fields ---
    uploaded_file = st.file_uploader("Upload Chapter PDF", type=["pdf"])
    
    col1, col2 = st.columns(2)
    with col1:
        num_mcqs = st.number_input(
            "Number of MCQs", 
            min_value=10, 
            max_value=50, 
            value=10, 
            step=1
        )
    with col2:
        num_unit_tests = st.number_input(
            "Number of Unit Test Questions", 
            min_value=5, 
            max_value=40, 
            value=5, 
            step=1
        )
    
    # --- Submit Button ---
    submit_button = st.form_submit_button(label="🧠 Generate Content")

# --- Form Processing ---
if submit_button:
    if uploaded_file is not None:
        
        # Display a spinner while processing
        with st.spinner("Processing chapter... This may take a few minutes. ⏳"):
            
            # Prepare the file and data for the POST request
            files = {"file": (uploaded_file.name, uploaded_file.getvalue(), "application/pdf")}
            data = {
                "num_mcqs": num_mcqs,
                "num_unit_tests": num_unit_tests
            }
            
            try:
                # Send the request to the FastAPI backend
                response = requests.post(FASTAPI_ENDPOINT, files=files, data=data, timeout=300) # 5 min timeout
                
                # --- Handle Response ---
                if response.status_code == 200:
                    response_data = response.json()
                    st.success("✅ Content generated successfully!")
                    
                    # Show summary
                    summary = response_data.get("summary", {})
                    st.info(f"""
                    **Summary:**
                    - MCQs: {summary.get('mcqs_requested', 0)} requested ({summary.get('mcqs_length', 0)} chars)
                    - Unit Tests: {summary.get('unit_tests_requested', 0)} requested ({summary.get('unit_tests_length', 0)} chars)
                    - One-Nighter: {summary.get('one_nighter_length', 0)} characters
                    """)
                    
                    # Display generated content as markdown
                    data = response_data.get("data", {})
                    
                    # Helper function to strip leading heading from markdown
                    def strip_leading_heading(markdown_text):
                        """Remove the first # heading from markdown if present"""
                        if not markdown_text:
                            return ""
                        lines = markdown_text.strip().split('\n')
                        # Skip first line if it's a heading (starts with #)
                        if lines and lines[0].strip().startswith('#'):
                            return '\n'.join(lines[1:]).strip()
                        return markdown_text
                    
                    # One-Nighter Summary Section (show first)
                    one_nighter_content = data.get("one_nighter", "")
                    if one_nighter_content:
                        st.subheader("🌙 One-Nighter Summary")
                        st.markdown(strip_leading_heading(one_nighter_content))
                        st.divider()
                    
                    # MCQs Section
                    mcqs_content = data.get("mcqs", "")
                    if mcqs_content:
                        st.subheader("📝 Multiple Choice Questions")
                        st.markdown(strip_leading_heading(mcqs_content))
                        st.divider()
                    
                    # Unit Tests Section
                    unit_tests_content = data.get("unit_tests", "")
                    if unit_tests_content:
                        st.subheader("📝 Unit Test Questions")
                        st.markdown(strip_leading_heading(unit_tests_content))
                    
                    # Show file paths
                    st.subheader("💾 Generated Files:")
                    output_data = response_data.get("outputs", {})
                    for key, path in output_data.items():
                        st.text(f"{key.capitalize()}: {path}")

                else:
                    st.error(f"Error: {response.status_code}")
                    st.json(response.json())

            except requests.exceptions.RequestException as e:
                st.error(f"Failed to connect to the backend: {e}")
                st.info("Please make sure your FastAPI server is running.")
                
    else:
        st.warning("Please upload a PDF file to continue.")