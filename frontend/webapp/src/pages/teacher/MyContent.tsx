import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Upload, FileText, Trash2, Download, Eye, UserPlus } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

interface UploadedContent {
  id: string;
  fileName: string;
  uploadDate: string;
  numMCQs: number;
  numQuestions: number;
  tokenUsage: number;
}

export default function MyContent() {
  const { toast } = useToast();
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [numMCQs, setNumMCQs] = useState(10);
  const [numQuestions, setNumQuestions] = useState(10);
  const [isUploading, setIsUploading] = useState(false);
  const [uploadedContent, setUploadedContent] = useState<UploadedContent[]>([
    {
      id: "1",
      fileName: "Physics Chapter 1 - Teaching Material.pdf",
      uploadDate: "2025-11-03",
      numMCQs: 20,
      numQuestions: 15,
      tokenUsage: 1850
    }
  ]);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      if (file.size > 10 * 1024 * 1024) {
        toast({
          title: "File too large",
          description: "Maximum file size is 10MB",
          variant: "destructive"
        });
        return;
      }
      setSelectedFile(file);
    }
  };

  const handleUpload = async () => {
    if (!selectedFile) {
      toast({
        title: "No file selected",
        description: "Please select a file to upload",
        variant: "destructive"
      });
      return;
    }

    setIsUploading(true);
    
    // Simulate upload - replace with actual API call
    setTimeout(() => {
      const newContent: UploadedContent = {
        id: Date.now().toString(),
        fileName: selectedFile.name,
        uploadDate: new Date().toISOString().split('T')[0],
        numMCQs,
        numQuestions,
        tokenUsage: Math.floor(Math.random() * 2000) + 500
      };
      
      setUploadedContent(prev => [newContent, ...prev]);
      setSelectedFile(null);
      setIsUploading(false);
      
      toast({
        title: "Upload successful",
        description: "Your content has been processed successfully"
      });
    }, 2000);
  };

  const handleDelete = (id: string) => {
    setUploadedContent(prev => prev.filter(item => item.id !== id));
    toast({
      title: "Content deleted",
      description: "Content has been removed successfully"
    });
  };

  const handleAssign = (id: string) => {
    toast({
      title: "Assignment feature",
      description: "This will open student selection dialog"
    });
  };

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold text-foreground">My Content</h1>
          <p className="text-muted-foreground">Upload teaching materials and assign tests to students</p>
        </div>

        {/* Upload Section */}
        <Card>
          <CardHeader>
            <CardTitle>Upload Teaching Content</CardTitle>
            <CardDescription>
              Upload PDF, DOCX, or image files (max 10MB) to generate AI-powered summaries and assignable tests
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* File Upload */}
            <div className="space-y-2">
              <Label htmlFor="file-upload">Select File</Label>
              <div className="flex items-center gap-4">
                <Input
                  id="file-upload"
                  type="file"
                  accept=".pdf,.docx,.doc,.jpg,.jpeg,.png"
                  onChange={handleFileChange}
                  className="flex-1"
                />
                {selectedFile && (
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <FileText className="h-4 w-4" />
                    <span>{selectedFile.name}</span>
                  </div>
                )}
              </div>
            </div>

            {/* Number Controls */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="num-mcqs">Number of MCQs (5-50)</Label>
                <div className="flex items-center gap-4">
                  <Input
                    id="num-mcqs"
                    type="range"
                    min="5"
                    max="50"
                    value={numMCQs}
                    onChange={(e) => setNumMCQs(Number(e.target.value))}
                    className="flex-1"
                  />
                  <Input
                    type="number"
                    min="5"
                    max="50"
                    value={numMCQs}
                    onChange={(e) => setNumMCQs(Math.min(50, Math.max(5, Number(e.target.value))))}
                    className="w-20"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="num-questions">Number of Questions (5-50)</Label>
                <div className="flex items-center gap-4">
                  <Input
                    id="num-questions"
                    type="range"
                    min="5"
                    max="50"
                    value={numQuestions}
                    onChange={(e) => setNumQuestions(Number(e.target.value))}
                    className="flex-1"
                  />
                  <Input
                    type="number"
                    min="5"
                    max="50"
                    value={numQuestions}
                    onChange={(e) => setNumQuestions(Math.min(50, Math.max(5, Number(e.target.value))))}
                    className="w-20"
                  />
                </div>
              </div>
            </div>

            <Button 
              onClick={handleUpload} 
              disabled={!selectedFile || isUploading}
              className="w-full md:w-auto"
            >
              <Upload className="mr-2 h-4 w-4" />
              {isUploading ? "Processing..." : "Upload and Generate"}
            </Button>
          </CardContent>
        </Card>

        {/* Uploaded Content List */}
        <Card>
          <CardHeader>
            <CardTitle>Your Teaching Content</CardTitle>
            <CardDescription>
              View, manage, and assign AI-generated study materials to students
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {uploadedContent.map((content) => (
                <Card key={content.id}>
                  <CardContent className="pt-6">
                    <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <div className="flex items-center gap-2">
                          <FileText className="h-5 w-5 text-primary" />
                          <h3 className="font-semibold">{content.fileName}</h3>
                        </div>
                        <p className="text-sm text-muted-foreground">
                          Uploaded: {content.uploadDate} • {content.numMCQs} MCQs • {content.numQuestions} Questions • {content.tokenUsage} tokens
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button variant="outline" size="icon">
                          <Eye className="h-4 w-4" />
                        </Button>
                        <Button variant="outline" size="icon">
                          <Download className="h-4 w-4" />
                        </Button>
                        <Button 
                          variant="outline" 
                          size="icon"
                          onClick={() => handleDelete(content.id)}
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>

                    <Tabs defaultValue="summary" className="mt-4">
                      <TabsList className="grid w-full grid-cols-3">
                        <TabsTrigger value="summary">One-Nighter</TabsTrigger>
                        <TabsTrigger value="questions">Unit Test</TabsTrigger>
                        <TabsTrigger value="mcqs">MCQs</TabsTrigger>
                      </TabsList>
                      <TabsContent value="summary" className="space-y-4">
                        <p className="text-sm text-muted-foreground">AI-generated summary will appear here</p>
                      </TabsContent>
                      <TabsContent value="questions" className="space-y-4">
                        <p className="text-sm text-muted-foreground mb-4">Unit test questions will appear here</p>
                        <Button onClick={() => handleAssign(content.id)}>
                          <UserPlus className="mr-2 h-4 w-4" />
                          Assign to Students
                        </Button>
                      </TabsContent>
                      <TabsContent value="mcqs" className="space-y-4">
                        <p className="text-sm text-muted-foreground mb-4">MCQ questions will appear here</p>
                        <Button onClick={() => handleAssign(content.id)}>
                          <UserPlus className="mr-2 h-4 w-4" />
                          Assign to Students
                        </Button>
                      </TabsContent>
                    </Tabs>
                  </CardContent>
                </Card>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}
