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
                    st.success("✅ Content generated successfully!")
                    st.json(response.json())
                    
                    # Bonus: Show the generated file paths from your `temp_outputs`
                    st.subheader("Generated Files:")
                    output_data = response.json().get("outputs", {})
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