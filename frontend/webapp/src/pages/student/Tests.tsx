import { useState, useEffect, useCallback, Children } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Clock, Download, FileText, CheckCircle, Upload, Play, StopCircle, SkipForward, Hourglass, ChevronDown } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

// 🚨 IMPORTANT: REPLACE THESE MOCK COMPONENTS WITH YOUR ACTUAL SHADCN/RADIX IMPORTS
// If you are using Shadcn, replace this entire block with:
// import { Accordion, AccordionItem, AccordionTrigger, AccordionContent } from "@/components/ui/accordion"; 

// --- ROBUST MOCK ACCORDION COMPONENTS (for demonstration/error-checking) ---
const Accordion = ({ children, type = "single", value, onValueChange, ...props }: any) => {
    
    // Helper function to handle toggle logic for both single and multiple types
    const handleToggle = (id: string) => {
        if (type === "single") {
            onValueChange(value === id ? null : id);
        } else if (type === "multiple" && Array.isArray(value)) {
            const index = value.indexOf(id);
            let newValue = [...value];
            if (index > -1) {
                newValue.splice(index, 1); // Close it
            } else {
                newValue.push(id); // Open it
            }
            onValueChange(newValue);
        }
    };

    return (
        <div {...props} className="space-y-4">
            {Children.map(children, (child: any) => {
                const itemId = child?.props?.value;
                const isOpen = type === "single" ? value === itemId : (Array.isArray(value) && value.includes(itemId));
                
                return (
                    <div key={itemId} className="border rounded-lg shadow-md">
                        {Children.map(child?.props?.children, (subChild: any) => {
                            if (subChild?.type === AccordionTrigger) {
                                return (
                                    <div 
                                        onClick={() => handleToggle(itemId)} 
                                        className="flex justify-between items-center w-full p-4 font-medium hover:bg-muted/50 transition-colors cursor-pointer"
                                    >
                                        {subChild?.props?.children} 
                                        <ChevronDown className={`h-5 w-5 shrink-0 transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`} />
                                    </div>
                                );
                            }
                            if (subChild?.type === AccordionContent && isOpen) {
                                return <div className="p-4 border-t">{subChild?.props?.children}</div>;
                            }
                            return null;
                        })}
                    </div>
                );
            })}
        </div>
    );
};
const AccordionItem = ({ value, children }: any) => <>{children}</>;
const AccordionTrigger = ({ children }: any) => <>{children}</>;
const AccordionContent = ({ children }: any) => <>{children}</>;
// ---------------------------------------------------------------------

// --- Data Structures (Same as before) ---
interface AssignedTest {
  id: string;
  title: string;
  source: 'AI-MCQs' | 'Teacher-Upload' | 'Google-Form';
  status: 'Pending' | 'InProgress' | 'Submitted';
  dueDate: string;
  timeLimitMinutes: number;
  downloadUrl?: string; 
  quizUrl?: string; 
  submissionFile?: File | null;
  startTime?: number | null; 
  timeSpentSeconds?: number;
  teacherInsight?: 'On Time' | 'Late' | 'Quick' | 'Not Reviewed';
  timeDifference?: number; 
  laps?: number[]; 
}

// --- Helper Functions (Same as before) ---
const formatTime = (seconds: number) => {
    const absSeconds = Math.abs(seconds);
    const mins = Math.floor(absSeconds / 60);
    const secs = absSeconds % 60;
    return `${mins}m ${secs}s`;
}

const getInsightText = (insight: string | undefined, diff: number | undefined) => {
    if (!insight || diff === undefined) return null;
    const absDiff = Math.abs(diff);
    const time = formatTime(absDiff);
    
    if (insight === 'Quick') {
        return `You were quick by ${time}`;
    } else if (insight === 'Late') {
        return `You were late by ${time}`;
    }
    return 'Completed on time';
}

// --- Timer Component (Same as before) ---
const Timer = ({
    testId,
    initialTimeSpent = 0,
    initialLaps = [],
    onStart,
    onStop,
    onLap,
    isRunning,
    currentTime,
  }: {
    testId: string;
    initialTimeSpent?: number;
    initialLaps?: number[];
    onStart: (id: string) => void;
    onStop: (id: string) => void;
    onLap: (id: string, totalTime: number) => void;
    isRunning: boolean;
    currentTime: number;
  }) => {
    const displayTime = formatTime(currentTime);
  
    return (
      <Card className="bg-muted p-4 space-y-3">
          <div className="flex justify-between items-center">
              <h4 className="text-xl font-bold text-primary">{displayTime}</h4>
              <div className="space-x-2">
                  {!isRunning && (
                      <Button onClick={() => onStart(testId)} size="sm">
                          <Play className="mr-2 h-4 w-4" /> Start Timer
                      </Button>
                  )}
                  {isRunning && (
                      <Button onClick={() => onLap(testId, currentTime)} variant="outline" size="sm">
                          <SkipForward className="mr-2 h-4 w-4" /> Lap (Question)
                      </Button>
                  )}
                  <Button onClick={() => onStop(testId)} variant={isRunning ? "destructive" : "secondary"} size="sm">
                      <StopCircle className="mr-2 h-4 w-4" /> Stop
                  </Button>
              </div>
          </div>
          
          {initialLaps.length > 0 && (
              <div className="border-t pt-2 max-h-40 overflow-y-auto">
                  <p className="text-sm font-medium mb-1">Question Times (Laps):</p>
                  <div className="space-y-1">
                      {initialLaps.map((lapTime, index) => {
                          const previousLapTime = index > 0 ? initialLaps[index - 1] : 0;
                          const lapDuration = lapTime - previousLapTime;
                          return (
                              <div key={index} className="flex justify-between text-xs text-muted-foreground">
                                  <span>Lap {index + 1} ({formatTime(lapDuration)}):</span>
                                  <span className="font-semibold text-foreground">{formatTime(lapTime)}</span>
                              </div>
                          );
                      })}
                  </div>
              </div>
          )}
      </Card>
    );
  };
// --- END Timer Component ---


export default function StudentTests() {
  const { toast } = useToast();
  const [currentTime, setCurrentTime] = useState(0); 
  const [activeTestId, setActiveTestId] = useState<string | null>(null);
  
  // 🟢 FIX: openTestId must be an array for 'multiple' type
  const [openTestId, setOpenTestId] = useState<string[]>(["T-101"]); 
  
  const [tests, setTests] = useState<AssignedTest[]>([
    {
      id: "T-101",
      title: "Science Chapter 5 Unit Test",
      source: "Teacher-Upload",
      status: "Pending",
      dueDate: "2025-11-15",
      timeLimitMinutes: 60,
      downloadUrl: "/api/tests/t101/download",
      laps: [],
    },
    {
      id: "T-102",
      title: "AI-Generated MCQs (Physics Ch 1)",
      source: "AI-MCQs",
      status: "Pending",
      dueDate: "2025-11-10",
      timeLimitMinutes: 30,
      quizUrl: "/app/live-quiz/T-102", 
      laps: [],
    },
    {
      id: "T-103",
      title: "Democratic Politics Quiz",
      source: "Google-Form",
      status: "Submitted",
      dueDate: "2025-11-20",
      timeLimitMinutes: 45,
      quizUrl: "https://docs.google.com/forms/d/e/...", 
      timeSpentSeconds: 2100, // 35 mins
      teacherInsight: 'Quick',
      timeDifference: -600,
      laps: [50, 100, 150, 2100],
    },
  ]);
  
  const activeTest = tests.find(t => t.id === activeTestId);
  const isTimerRunning = activeTest?.status === 'InProgress';

  // --- Timer useEffect (omitted for brevity) ---
  useEffect(() => {
    let interval: NodeJS.Timeout | null = null;
    if (isTimerRunning && activeTest?.startTime) {
      interval = setInterval(() => {
        setCurrentTime(Math.floor((Date.now() - activeTest.startTime!) / 1000));
      }, 1000);
    } else if (!isTimerRunning && interval) {
      clearInterval(interval);
    }
    return () => { if (interval) clearInterval(interval); };
  }, [isTimerRunning, activeTest?.startTime]);
  
  // --- Timer Actions (omitted for brevity) ---
  const handleStartTimer = (id: string) => {
    if (activeTestId && activeTestId !== id) {
        toast({ title: "Error", description: `Please stop the timer for ${activeTest?.title} first.`, variant: "destructive" });
        return;
    }
    const testToStart = tests.find(t => t.id === id);
    const initialTime = testToStart?.timeSpentSeconds || 0;
    
    setTests(tests.map(test => 
        test.id === id ? { ...test, status: 'InProgress', startTime: Date.now() - initialTime * 1000 } : test
    ));
    setActiveTestId(id);
    setCurrentTime(initialTime);
    toast({ title: "Timer Resumed", description: "Your test time is now running." });
  };

  const handleStopTimer = useCallback((id: string) => {
    const timeSpentSeconds = currentTime;
    
    setTests(tests.map(t => 
      t.id === id ? { ...t, status: 'Pending', startTime: null, timeSpentSeconds: timeSpentSeconds } : t
    ));
    
    setActiveTestId(null);
    setCurrentTime(0);
    toast({ title: "Timer Stopped", description: `Time logged: ${formatTime(timeSpentSeconds)}.` });
  }, [tests, currentTime]);

  const handleLap = useCallback((id: string, totalTime: number) => {
    const newLapTime = totalTime;
    setTests(tests.map(test => {
        if (test.id === id) {
            const newLaps = test.laps ? [...test.laps, newLapTime] : [newLapTime];
            toast({ title: `Lap ${newLaps.length} Recorded`, description: "Time saved for the question." });
            return { ...test, laps: newLaps };
        }
        return test;
    }));
  }, [tests]);

  // --- Submission Logic (omitted for brevity) ---
  const handleFileChange = (id: string, file: File | null) => {
    setTests(tests.map(test => 
      test.id === id ? { ...test, submissionFile: file } : test
    ));
  };

  const handleSubmit = (id: string) => {
    const test = tests.find(t => t.id === id);
    
    if (test?.status === 'InProgress') {
        toast({ title: "Timer Running", description: "Please stop the timer before submission.", variant: "destructive" });
        return;
    }
    if (test?.source === 'Teacher-Upload' && !test?.submissionFile) {
        toast({ title: "Submission Failed", description: "Please upload a completed test file.", variant: "destructive" });
        return;
    }

    const timeLimitSeconds = test?.timeLimitMinutes ? test.timeLimitMinutes * 60 : Infinity;
    const recordedTime = test?.timeSpentSeconds || 0;
    
    let insight: 'On Time' | 'Late' | 'Quick' = 'On Time';
    let timeDiff = 0;

    if (recordedTime > timeLimitSeconds) {
        insight = 'Late';
        timeDiff = recordedTime - timeLimitSeconds;
    } else if (recordedTime < timeLimitSeconds) {
        insight = 'Quick';
        timeDiff = recordedTime - timeLimitSeconds;
    }

    setTests(tests.map(t => 
        t.id === id ? { 
            ...t, 
            status: 'Submitted', 
            submissionFile: null, 
            startTime: null, 
            teacherInsight: insight, 
            timeDifference: timeDiff
        } : t
    ));

    toast({ title: "Test Submitted", description: "Your test details and timing were recorded." });
  };
  
  const handleAccessQuiz = (url: string, source: string) => {
      // Logic for accessing the quiz...
      toast({ title: "Launching Quiz", description: `Opening ${source} link...`, });
      if (source === 'Google-Form') {
          window.open(url, '_blank', 'noopener,noreferrer');
      }
  };


  return (
    <DashboardLayout>
      <div className="container mx-auto px-4 pt-6 pb-6 space-y-6"> 
        <div>
          <h1 className="text-3xl font-bold text-foreground">My Tests</h1>
          <p className="text-muted-foreground">View assigned tests, manage timers, and submit your work.</p>
        </div>

        {/* 🟢 FIX: Updated type to "multiple" */}
        <Accordion type="multiple" value={openTestId} onValueChange={setOpenTestId}>
          {tests.map((test) => (
            // 🟢 FIX: AccordionItem key/value prop fixed
            <AccordionItem key={test.id} value={test.id}> 
              <AccordionTrigger>
                <div className="flex flex-col text-left">
                    <span className="text-xl font-bold text-foreground">{test.title}</span>
                    <span className="text-sm text-muted-foreground">
                        Source: {test.source} • Limit: {test.timeLimitMinutes} min • Due: {test.dueDate}
                    </span>
                </div>
                <div className={`px-3 py-1 text-sm font-semibold rounded-full shrink-0 ${
                    test.status === 'Pending' ? 'bg-yellow-100 text-yellow-800' :
                    test.status === 'InProgress' ? 'bg-blue-100 text-blue-800' :
                    'bg-green-100 text-green-800'
                  }`}>
                  {test.status}
                </div>
              </AccordionTrigger>

              <AccordionContent className="space-y-4">
              
                {/* Submission Status & Insight */}
                {test.status === 'Submitted' && (
                    <div className="flex flex-col space-y-2 border-b pb-4">
                        <div className="flex items-center gap-2 text-sm text-green-600 font-medium">
                            <CheckCircle className="h-4 w-4" />
                            Submitted on time. Insight: <span className="text-foreground font-bold">{getInsightText(test.teacherInsight, test.timeDifference)}</span>
                        </div>
                        <p className="text-sm text-muted-foreground">
                            Total Recorded Session Time: **{formatTime(test.timeSpentSeconds || 0)}**
                        </p>
                        {test.laps && test.laps.length > 0 && (
                            <p className="text-sm text-muted-foreground">
                                <span className="font-semibold">Laps Recorded:</span> {test.laps.length} questions tracked.
                            </p>
                        )}
                    </div>
                )}

                {/* Pending Actions */}
                {test.status !== 'Submitted' && (
                  <div className="space-y-4">
                    <p className="text-sm font-medium text-muted-foreground">Test Access:</p>
                    
                    {/* Download/Access Button */}
                    {(test.source === 'Teacher-Upload' && test.downloadUrl) && (
                        <Button variant="outline" className="w-full" onClick={() => window.open(test.downloadUrl, '_blank')} disabled={test.status === 'InProgress'}>
                            <Download className="mr-2 h-4 w-4" /> Download Test File (PDF/DOCX)
                        </Button>
                    )}
                    {((test.source === 'AI-MCQs' || test.source === 'Google-Form') && test.quizUrl) && (
                        <Button variant="default" className="w-full" onClick={() => handleAccessQuiz(test.quizUrl!, test.source)} disabled={test.status === 'InProgress'}>
                            <Play className="mr-2 h-4 w-4" /> Start {test.source === 'AI-MCQs' ? 'Live Quiz' : 'External Form'}
                        </Button>
                    )}
                    
                    {/* Timer Section */}
                    <div className="border p-4 rounded-lg space-y-3">
                        <p className="text-md font-semibold flex items-center gap-2 text-accent-foreground">
                            <Hourglass className="h-5 w-5 text-accent"/> Self-Assessment Timer (for internal tracking)
                        </p>
                         
                        {(activeTestId === test.id || test.timeSpentSeconds) ? (
                              <Timer
                                  testId={test.id}
                                  initialTimeSpent={test.timeSpentSeconds}
                                  initialLaps={test.laps}
                                  onStart={handleStartTimer}
                                  onStop={handleStopTimer}
                                  onLap={handleLap}
                                  isRunning={test.status === 'InProgress'}
                                  currentTime={test.status === 'InProgress' ? currentTime : (test.timeSpentSeconds || 0)}
                              />
                         ) : (
                             <Button onClick={() => handleStartTimer(test.id)} className="w-full" variant="outline" disabled={test.status === 'InProgress'}>
                                  <Play className="mr-2 h-4 w-4" /> Start Session Timer
                             </Button>
                         )}
                    </div>
                    
                    {/* Submission Section */}
                    {test.source === 'Teacher-Upload' && (
                        <div className="flex flex-col md:flex-row items-end gap-4 border-t pt-4">
                          <div className="flex-1 space-y-2 w-full">
                            <Label htmlFor={`file-submit-${test.id}`}>Upload Completed Test File</Label>
                            <Input
                              id={`file-submit-${test.id}`}
                              type="file"
                              accept=".pdf,.docx,.doc,.jpg,.jpeg,.png"
                              onChange={(e) => handleFileChange(test.id, e.target.files?.[0] || null)}
                              className="flex-1"
                            />
                          </div>
                          
                          <Button 
                            onClick={() => handleSubmit(test.id)} 
                            disabled={!test.submissionFile || test.status === 'InProgress'}
                            className="w-full md:w-auto"
                          >
                            <Upload className="mr-2 h-4 w-4" /> Submit Test & Time
                          </Button>
                        </div>
                    )}
                    
                    {/* Submit for Quiz/Form */}
                     {(test.source === 'AI-MCQs' || test.source === 'Google-Form') && (
                         <div className="border-t pt-4">
                              <Button 
                                onClick={() => handleSubmit(test.id)} 
                                disabled={test.status === 'InProgress'}
                                className="w-full"
                              >
                                <CheckCircle className="mr-2 h-4 w-4" /> Mark as Completed & Submit Time
                              </Button>
                         </div>
                     )}
                  </div>
                )}
              </AccordionContent>
            </AccordionItem>
          ))}
        </Accordion>
      </div>
    </DashboardLayout>
  );
}