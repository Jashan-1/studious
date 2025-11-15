import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Upload, FileText, Trash2, Download, ExternalLink, FolderOpen } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

interface ExtraContent {
  id: string;
  title: string;
  fileName: string;
  uploadDate: string;
  type: 'PDF' | 'DOCX' | 'Notes';
  downloadUrl: string;
}

export default function TeacherStudentContent() {
  const { toast } = useToast();
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [contentTitle, setContentTitle] = useState('');
  const [isUploading, setIsUploading] = useState(false);
  const [uploadedMaterials, setUploadedMaterials] = useState<ExtraContent[]>([
    {
      id: "M-101",
      title: "Algebra Shortcuts Guide",
      fileName: "Algebra_Shortcuts.pdf",
      uploadDate: "2025-11-01",
      type: 'PDF',
      downloadUrl: "/api/content/m101/download"
    },
    {
        id: "M-102",
        title: "Chemistry Bonding Flashcards",
        fileName: "Chem_Flashcards.docx",
        uploadDate: "2025-10-28",
        type: 'DOCX',
        downloadUrl: "/api/content/m102/download"
    }
  ]);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Basic validation logic
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
    if (!selectedFile || !contentTitle) {
      toast({
        title: "Missing Information",
        description: "Please provide both a file and a title.",
        variant: "destructive"
      });
      return;
    }

    setIsUploading(true);
    
    // Simulate upload and processing
    setTimeout(() => {
      const extension = selectedFile.name.split('.').pop()?.toUpperCase();
      const newContent: ExtraContent = {
        id: Date.now().toString(),
        title: contentTitle,
        fileName: selectedFile.name,
        uploadDate: new Date().toISOString().split('T')[0],
        type: (extension === 'PDF' || extension === 'DOCX') ? extension as 'PDF' | 'DOCX' : 'Notes',
        downloadUrl: `/api/content/${Date.now()}/download`
      };
      
      setUploadedMaterials(prev => [newContent, ...prev]);
      setSelectedFile(null);
      setContentTitle('');
      setIsUploading(false);
      
      toast({
        title: "Upload successful",
        description: `${newContent.title} is now visible to students.`
      });
    }, 2000);
  };

  const handleDelete = (id: string) => {
    setUploadedMaterials(prev => prev.filter(item => item.id !== id));
    toast({
      title: "Content deleted",
      description: "Material has been removed successfully"
    });
  };

  return (
    <DashboardLayout>
      <div className="container mx-auto px-4 pt-6 pb-6 space-y-6">
        <div>
          <h1 className="text-3xl font-bold text-foreground flex items-center gap-2">
            <FolderOpen className="h-7 w-7 text-primary" /> Student Content Manager
          </h1>
          <p className="text-muted-foreground">Upload supplementary books, notes, and study materials for your students.</p>
        </div>

        {/* Upload New Material Section */}
        <Card>
          <CardHeader>
            <CardTitle>Upload New Material</CardTitle>
            <CardDescription>
              Upload PDF, DOCX, or other educational files (max 10MB).
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
                <Label htmlFor="content-title">Material Title</Label>
                <Input 
                    id="content-title"
                    placeholder="e.g., Chapter 5 Quick Revision Notes"
                    value={contentTitle}
                    onChange={(e) => setContentTitle(e.target.value)}
                />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="file-upload">Select File</Label>
              <Input
                  id="file-upload"
                  type="file"
                  accept=".pdf,.docx,.doc,.jpg,.jpeg,.png"
                  onChange={handleFileChange}
                  className="flex-1"
              />
            </div>

            <Button 
              onClick={handleUpload} 
              disabled={!selectedFile || !contentTitle || isUploading}
              className="w-full md:w-auto"
            >
              <Upload className="mr-2 h-4 w-4" />
              {isUploading ? "Uploading..." : "Upload Material"}
            </Button>
          </CardContent>
        </Card>

        {/* Uploaded Material List */}
        <Card>
          <CardHeader>
            <CardTitle>Currently Available Materials</CardTitle>
            <CardDescription>
              These materials are visible to all students under My Books.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {uploadedMaterials.map((content) => (
                <div key={content.id} className="flex items-center justify-between p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                    <div className="space-y-1">
                      <h3 className="font-semibold">{content.title}</h3>
                      <p className="text-sm text-muted-foreground">
                        File: {content.fileName} • Type: <span className="font-bold">{content.type}</span> • Uploaded: {content.uploadDate}
                      </p>
                    </div>
                    <div className="flex items-center gap-2">
                      <Button variant="outline" size="sm" onClick={() => window.open(content.downloadUrl, '_blank')}>
                        <Download className="h-4 w-4 mr-2" /> Download
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
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}