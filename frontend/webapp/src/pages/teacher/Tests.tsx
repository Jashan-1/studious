import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Timer, Send, Clock, FileText, BarChart, XCircle, File, Link, Zap } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";


// --- Data Structures ---
interface AssignedTest {
  id: string;
  title: string;
  source: 'AI-MCQs' | 'Teacher-Upload' | 'Google-Form';
  dueDate: string;
  timeLimitMinutes: number;
  quizUrl?: string;
  downloadUrl?: string; 
}

interface StudentSubmission {
  studentName: string;
  submissionDate: string;
  timeSpentSeconds: number;
  timeDifference: number; // vs timeLimitMinutes (negative is Quick)
  insight: 'On Time' | 'Late' | 'Quick';
}

interface TestAssignment extends AssignedTest {
  submissions: StudentSubmission[];
}

// --- Helper Functions ---
const formatTimeDifference = (seconds: number) => {
    const absSeconds = Math.abs(seconds);
    const mins = Math.floor(absSeconds / 60);
    const secs = absSeconds % 60;
    return `${mins}m ${secs}s`;
}

const getInsightClass = (insight: string) => {
  switch (insight) {
    case 'Quick':
      return 'bg-green-100 text-green-800';
    case 'Late':
      return 'bg-red-100 text-red-800';
    case 'On Time':
    default:
      return 'bg-blue-100 text-blue-800';
  }
};


export default function TeacherTests() {
  const { toast } = useToast();
  const [newTestTitle, setNewTestTitle] = useState('');
  const [newTestSource, setNewTestSource] = useState<'Teacher-Upload' | 'Google-Form'>('Teacher-Upload');
  const [newTimeLimit, setNewTimeLimit] = useState(60); 
  const [newDueDate, setNewDueDate] = useState(new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]); // Default 7 days from now
  const [newQuizUrl, setNewQuizUrl] = useState('');
  const [newUploadFile, setNewUploadFile] = useState<File | null>(null);

  const [assignments, setAssignments] = useState<TestAssignment[]>([
    {
      id: "T-101",
      title: "Science Chapter 5 Unit Test",
      source: "Teacher-Upload",
      dueDate: "2025-11-15",
      timeLimitMinutes: 60,
      downloadUrl: "/api/tests/t101/download",
      submissions: [
        { studentName: "Student A", submissionDate: "2025-11-14", timeSpentSeconds: 3000, timeDifference: -600, insight: 'Quick' }, 
        { studentName: "Student B", submissionDate: "2025-11-16", timeSpentSeconds: 4000, timeDifference: 400, insight: 'Late' }, 
        { studentName: "Student C", submissionDate: "2025-11-14", timeSpentSeconds: 3600, timeDifference: 0, insight: 'On Time' }, 
      ]
    },
    {
        id: "T-102-AI",
        title: "AI-Generated MCQs (Physics Ch 1)",
        source: "AI-MCQs",
        dueDate: "2025-11-10",
        timeLimitMinutes: 30,
        quizUrl: "/app/live-quiz/T-102",
        submissions: [
            { studentName: "Student D", submissionDate: "2025-11-10", timeSpentSeconds: 1500, timeDifference: -300, insight: 'Quick' }, 
        ]
    }
  ]);
  
  // --- Core Assignment Logic ---
  const handleCreateTest = () => {
    if (!newTestTitle || !newTimeLimit || !newDueDate) {
      toast({ title: "Error", description: "Please fill all required fields.", variant: "destructive" });
      return;
    }

    if (newTestSource === 'Teacher-Upload' && !newUploadFile) {
        toast({ title: "Error", description: "Please upload the test file.", variant: "destructive" });
        return;
    }
    
    if (newTestSource === 'Google-Form' && !newQuizUrl.startsWith('http')) {
        toast({ title: "Error", description: "Please enter a valid URL.", variant: "destructive" });
        return;
    }

    const newAssignment: TestAssignment = {
      id: `T-${Date.now()}`,
      title: newTestTitle,
      source: newTestSource,
      dueDate: newDueDate,
      timeLimitMinutes: newTimeLimit,
      quizUrl: newTestSource === 'Google-Form' ? newQuizUrl : undefined,
      downloadUrl: newTestSource === 'Teacher-Upload' ? `/api/tests/uploads/${newUploadFile?.name}` : undefined,
      submissions: [],
    };

    setAssignments(prev => [newAssignment, ...prev]);
    setNewTestTitle('');
    setNewTimeLimit(60);
    setNewQuizUrl('');
    setNewUploadFile(null);
    toast({ title: "Test Assigned", description: `${newTestTitle} has been assigned to students.` });
  };
  
  // --- Function to handle assignments coming from MyContent.tsx ---
  // This is the function the 'Assign MCQs' button in MyContent.tsx would trigger.
  const handleAssignAIContent = (contentTitle: string, mcqCount: number) => {
      // Simulate creating a structured test from AI-generated content
      const newAssignment: TestAssignment = {
        id: `T-${Date.now()}-AI`,
        title: `${contentTitle} (AI Quiz)`,
        source: 'AI-MCQs',
        dueDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        timeLimitMinutes: mcqCount * 2, // Example: 2 minutes per MCQ
        quizUrl: `/app/live-quiz/T-${Date.now()}`, // Internal link for the live quiz
        submissions: [],
      };
      setAssignments(prev => [newAssignment, ...prev]);
      toast({ title: "Content Assigned", description: `${newAssignment.title} has been assigned as a live quiz with a ${newAssignment.timeLimitMinutes} minute limit.` });
  }

  return (
    <DashboardLayout>
      <div className="container mx-auto px-4 pt-6 space-y-6">
        <div>
          <h1 className="text-3xl font-bold text-foreground">Test Management</h1>
          <p className="text-muted-foreground">Assign tests, set timers, and analyze student performance insights.</p>
        </div>

        {/* Create New Assignment Section */}
        <Card className="shadow-md">
          <CardHeader>
            <CardTitle>Create New Test Assignment</CardTitle>
            <CardDescription>Set the parameters for a new test for your students.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <Input 
              placeholder="Test Title (e.g., Algebra Mid-Term)"
              value={newTestTitle}
              onChange={(e) => setNewTestTitle(e.target.value)}
            />
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <Label>Assignment Source</Label>
                    <Select value={newTestSource} onValueChange={(value) => setNewTestSource(value as 'Teacher-Upload' | 'Google-Form')}>
                        <SelectTrigger>
                            <SelectValue placeholder="Select Source Type" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="Teacher-Upload">Downloadable File (PDF/DOCX)</SelectItem>
                            <SelectItem value="Google-Form">External Link (Google Form, etc.)</SelectItem>
                        </SelectContent>
                    </Select>
                </div>
                
                {newTestSource === 'Teacher-Upload' ? (
                    <div>
                        <Label htmlFor="uploadFile">Upload Test File</Label>
                        <Input
                            id="uploadFile"
                            type="file"
                            accept=".pdf,.docx,.doc"
                            onChange={(e) => setNewUploadFile(e.target.files?.[0] || null)}
                        />
                    </div>
                ) : (
                    <div>
                        <Label htmlFor="quizUrl">External Quiz URL (e.g., Google Form)</Label>
                        <Input
                            id="quizUrl"
                            type="url"
                            placeholder="https://docs.google.com/forms/d/..."
                            value={newQuizUrl}
                            onChange={(e) => setNewQuizUrl(e.target.value)}
                        />
                    </div>
                )}
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <Label htmlFor="dueDate">Due Date</Label>
                    <Input 
                        id="dueDate"
                        type="date"
                        value={newDueDate}
                        onChange={(e) => setNewDueDate(e.target.value)}
                    />
                </div>
                <div>
                    <Label htmlFor="timeLimit">Time Limit (Minutes)</Label>
                    <Input
                        id="timeLimit"
                        type="number"
                        min="5"
                        max="180"
                        value={newTimeLimit}
                        onChange={(e) => setNewTimeLimit(Number(e.target.value))}
                    />
                </div>
                <div className="flex items-end">
                    <Button onClick={handleCreateTest} className="w-full">
                        <Send className="mr-2 h-4 w-4" /> Assign Test
                    </Button>
                </div>
            </div>
            
            <div className="flex items-center justify-between p-2 bg-yellow-50 border border-yellow-200 rounded-md text-sm text-yellow-800">
                <p>
                    <Zap className="h-4 w-4 inline mr-1" /> To assign AI-generated content (MCQs), please use the 'Assign' button on the **My Content** page.
                </p>
                {/* Simulate button trigger */}
                <Button variant="ghost" size="sm" onClick={() => handleAssignAIContent('Sample AI Physics Ch 2', 20)}>
                    Simulate AI Assignment
                </Button>
            </div>
          </CardContent>
        </Card>

        {/* Assigned Tests List */}
        <Card className="shadow-md">
          <CardHeader>
            <CardTitle>Current Assignments</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            {assignments.map((assignment) => (
              <div key={assignment.id} className="border p-4 rounded-lg space-y-3">
                <div className="flex justify-between items-start">
                  <div>
                    <h3 className="text-lg font-semibold">{assignment.title}</h3>
                    <p className="text-sm text-muted-foreground flex items-center gap-1">
                      <Timer className="h-3 w-3" /> Limit: **{assignment.timeLimitMinutes} min** • Due: {assignment.dueDate} • Source: {assignment.source}
                    </p>
                  </div>
                  {assignment.source === 'Teacher-Upload' && (
                      <Button variant="outline" size="sm">
                        <File className="h-4 w-4 mr-2" /> View Assignment File
                      </Button>
                  )}
                   {assignment.source === 'Google-Form' && (
                      <Button variant="outline" size="sm" onClick={() => window.open(assignment.quizUrl, '_blank')}>
                        <Link className="h-4 w-4 mr-2" /> View Link
                      </Button>
                  )}
                  {assignment.source === 'AI-MCQs' && (
                      <Button variant="outline" size="sm">
                        <BarChart className="h-4 w-4 mr-2" /> View Live Quiz Results
                      </Button>
                  )}
                </div>

                <div className="border-t pt-3">
                    <p className="font-medium mb-2 flex items-center gap-2">
                        <BarChart className="h-5 w-5 text-primary"/> Submission Insights ({assignment.submissions.length} Students)
                    </p>
                    
                    <div className="space-y-2">
                        {assignment.submissions.length > 0 ? assignment.submissions.map((submission, index) => (
                            <div key={index} className="flex justify-between items-center text-sm p-2 bg-gray-50 rounded-md">
                                <span className="font-medium">{submission.studentName}</span>
                                
                                <div className="flex items-center gap-4">
                                    <span className="text-muted-foreground">
                                        Time: {formatTimeDifference(submission.timeSpentSeconds)}
                                    </span>
                                    <span className={`px-3 py-1 rounded-full text-xs font-semibold ${getInsightClass(submission.insight)}`}>
                                        {submission.insight}
                                    </span>
                                    {submission.timeDifference !== 0 && (
                                        <span className={`text-xs ${submission.timeDifference > 0 ? 'text-red-500' : 'text-green-500'}`}>
                                            ({submission.timeDifference > 0 ? `+${formatTimeDifference(submission.timeDifference)}` : `-${formatTimeDifference(Math.abs(submission.timeDifference))}`})
                                        </span>
                                    )}
                                </div>
                            </div>
                        )) : (
                             <p className="text-sm text-muted-foreground flex items-center gap-2">
                                <XCircle className="h-4 w-4"/> No submissions yet.
                             </p>
                        )}
                    </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}