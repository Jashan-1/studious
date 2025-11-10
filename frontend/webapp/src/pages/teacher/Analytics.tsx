import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Timer, BarChart, TrendingUp, Clock, Users, CheckCircle, XCircle } from "lucide-react";
import { Separator } from "@/components/ui/separator";
import { Badge } from "@/components/ui/badge";

// --- Data Structures (Mocked Data) ---
// Assuming this data structure is available from the assignment state (e.g., via a context/API)
interface StudentSubmission {
  studentName: string;
  submissionDate: string;
  timeSpentSeconds: number;
  timeDifference: number; // Negative is Quick, Positive is Late
  insight: 'On Time' | 'Late' | 'Quick';
}

const mockAllSubmissions: StudentSubmission[] = [
    { studentName: "Student A", submissionDate: "2025-11-14", timeSpentSeconds: 3000, timeDifference: -600, insight: 'Quick' }, 
    { studentName: "Student B", submissionDate: "2025-11-16", timeSpentSeconds: 4000, timeDifference: 400, insight: 'Late' }, 
    { studentName: "Student C", submissionDate: "2025-11-14", timeSpentSeconds: 3600, timeDifference: 0, insight: 'On Time' },
    { studentName: "Student D", submissionDate: "2025-11-10", timeSpentSeconds: 1500, timeDifference: -300, insight: 'Quick' },
];

const mockAssignments = [
    { title: "Science Chapter 5 Unit Test", submissions: 3, totalStudents: 30 },
    { title: "AI-Generated MCQs (Physics Ch 1)", submissions: 1, totalStudents: 30 },
    { title: "Maths Algebra Mid-Term", submissions: 25, totalStudents: 30 },
];

// --- Helper Functions ---
const formatTimeDifference = (seconds: number) => {
    const absSeconds = Math.abs(seconds);
    const mins = Math.floor(absSeconds / 60);
    const secs = absSeconds % 60;
    return `${mins}m ${secs}s`;
}

const calculateClassMetrics = (submissions: StudentSubmission[]) => {
    const submittedCount = submissions.length;
    let quickCount = 0;
    let lateCount = 0;
    let onTimeCount = 0;
    let totalTimeDifference = 0;
    let totalStudents = 30; // Mock total class size

    submissions.forEach(sub => {
        if (sub.insight === 'Quick') quickCount++;
        else if (sub.insight === 'Late') lateCount++;
        else if (sub.insight === 'On Time') onTimeCount++;
        
        if (sub.timeDifference !== undefined) {
             totalTimeDifference += sub.timeDifference;
        }
    });
    
    // Average Speed Insight
    let averageInsight = 'On Time';
    let averageDifference = 0;

    if (submittedCount > 0) {
        averageDifference = totalTimeDifference / submittedCount;
        if (averageDifference < -60) {
            averageInsight = 'Quick';
        } else if (averageDifference > 60) {
            averageInsight = 'Late';
        }
    }
    
    return {
        submittedCount,
        submissionRate: ((submittedCount / totalStudents) * 100).toFixed(0),
        quickCount,
        lateCount,
        onTimeCount,
        averageDifference: Math.round(averageDifference),
        averageInsight,
    };
}


export default function TeacherAnalytics() {
    const metrics = calculateClassMetrics(mockAllSubmissions);

    return (
        <DashboardLayout>
            <div className="container mx-auto px-4 pt-6 pb-6 space-y-8">
                <div>
                    <h1 className="text-3xl font-bold text-foreground flex items-center gap-2">
                        <BarChart className="h-7 w-7 text-primary" /> Class Performance Dashboard
                    </h1>
                    <p className="text-muted-foreground">Monitor test completion, timing trends, and class efficiency.</p>
                </div>

                <Separator />
                
                {/* --- Class Summary Cards --- */}
                <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                    
                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Overall Submission Rate
                            </CardTitle>
                            <CheckCircle className="w-5 h-5 text-green-500" />
                        </CardHeader>
                        <CardContent>
                            <div className="text-3xl font-bold">{metrics.submissionRate}%</div>
                            <p className="text-xs text-muted-foreground mt-1">
                                {metrics.submittedCount} submissions out of 30 students
                            </p>
                        </CardContent>
                    </Card>

                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Average Time Trend
                            </CardTitle>
                            <TrendingUp className={`w-5 h-5 ${metrics.averageInsight === 'Quick' ? 'text-green-600' : metrics.averageInsight === 'Late' ? 'text-red-600' : 'text-blue-600'}`} />
                        </CardHeader>
                        <CardContent>
                            <div className={`text-3xl font-bold ${metrics.averageInsight === 'Quick' ? 'text-green-600' : metrics.averageInsight === 'Late' ? 'text-red-600' : 'text-blue-600'}`}>
                                {metrics.averageInsight}
                            </div>
                            <p className="text-sm text-muted-foreground mt-1">
                                Avg. deviation: {formatTimeDifference(metrics.averageDifference)}
                            </p>
                        </CardContent>
                    </Card>

                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Quick Submissions
                            </CardTitle>
                            <Clock className="w-5 h-5 text-green-500" />
                        </CardHeader>
                        <CardContent>
                            <div className="text-3xl font-bold text-green-600">{metrics.quickCount}</div>
                            <p className="text-xs text-muted-foreground mt-1">Faster than time limit</p>
                        </CardContent>
                    </Card>
                    
                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Late Submissions
                            </CardTitle>
                            <XCircle className="w-5 h-5 text-red-500" />
                        </CardHeader>
                        <CardContent>
                            <div className="text-3xl font-bold text-red-600">{metrics.lateCount}</div>
                            <p className="text-xs text-muted-foreground mt-1">Slower than time limit</p>
                        </CardContent>
                    </Card>
                </div>
                
                {/* --- Assignment Submission Status List --- */}
                <Card className="shadow-md">
                    <CardHeader>
                        <CardTitle>Assignment Completion Status</CardTitle>
                        <CardDescription>View completion rates for individual assignments.</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        {mockAssignments.map((assignment, index) => (
                            <div key={index} className="flex justify-between items-center p-3 border-b last:border-b-0">
                                <p className="font-semibold">{assignment.title}</p>
                                <div className="text-right">
                                    <Badge variant="secondary" className="bg-blue-100 text-blue-800">
                                        {assignment.submissions} / {assignment.totalStudents} Submitted
                                    </Badge>
                                    <p className="text-xs text-muted-foreground mt-1">
                                        {((assignment.submissions / assignment.totalStudents) * 100).toFixed(0)}% Completion Rate
                                    </p>
                                </div>
                            </div>
                        ))}
                    </CardContent>
                </Card>
            </div>
        </DashboardLayout>
    );
}