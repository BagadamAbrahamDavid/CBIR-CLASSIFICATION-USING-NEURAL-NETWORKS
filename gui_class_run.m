function varargout = gui_class_run(varargin)
% GUI_CLASS_RUN M-file for gui_class_run.fig
%      GUI_CLASS_RUN, by itself, creates a new GUI_CLASS_RUN or raises the existing
%      singleton*.
%
%      H = GUI_CLASS_RUN returns the handle to a new GUI_CLASS_RUN or the handle to
%      the existing singleton*.
%
%      GUI_CLASS_RUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CLASS_RUN.M with the given input arguments.
%
%      GUI_CLASS_RUN('Property','Value',...) creates a new GUI_CLASS_RUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_class_run_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_class_run_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_class_run

% Last Modified by GUIDE v2.5 23-Feb-2017 16:38:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_class_run_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_class_run_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_class_run is made visible.
function gui_class_run_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_class_run (see VARARGIN)

% Choose default command line output for gui_class_run
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_class_run wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.pushbutton4,'Visible','off');set(handles.pushbutton5,'Visible','off');
set(handles.axes1,'Visible','off');set(handles.axes2,'Visible','off');set(handles.axes3,'Visible','off');
set(handles.axes4,'Visible','off');set(handles.axes5,'Visible','off');set(handles.axes6,'Visible','off');
set(handles.axes7,'Visible','off');set(handles.axes8,'Visible','off');set(handles.axes9,'Visible','off');
set(handles.axes10,'Visible','off');



% --- Outputs from this function are returned to the command line.
function varargout = gui_class_run_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton4,'Visible','on');set(handles.pushbutton5,'Visible','off');
set(handles.axes1,'Visible','on');set(handles.axes2,'Visible','on');set(handles.axes3,'Visible','on');
set(handles.axes4,'Visible','on');set(handles.axes5,'Visible','on');set(handles.axes6,'Visible','on');
set(handles.axes7,'Visible','on');set(handles.axes8,'Visible','on');set(handles.axes9,'Visible','on');
set(handles.axes10,'Visible','on');
pause(1);
[J P]=uigetfile('*.*','select the Query Image');
I=imread(strcat(P,J));
I=imresize(I,[256 256]);
axes(handles.axes1);imshow(I);title('Query Image');
I=im2double(I);
k=1;wn={'haar','db2','db4','dmey','bior1.1'};
for w=1:5                         % three wavelets 
for c=1:3                         % three band of colors
    T=I(:,:,c);    
for i=1:6                         % six decomposition levels
[a1,b1,c1,d1]=dwt2(T,wn{w});
fq(k,:)=my_feature(a1);          % extraction of features
T=a1;
k=k+1;
end
end
end
handles.fq=fq;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1,'Visible','off');
set(handles.pushbutton5,'Visible','on');
[J P]=uigetfile('*.*','select the Query Image');
I=imread(strcat(P,J));
I=imresize(I,[256 256]);
I=im2double(I);
k=1;wn={'haar','db2','db4','dmey','bior1.1'};
for w=1:5                         % three wavelets 
for c=1:3                         % three band of colors
    T=I(:,:,c);    
for i=1:6                         % six decomposition levels
[a1,b1,c1,d1]=dwt2(T,wn{w});
fq(k,:)=my_feature(a1);          % extraction of features
T=a1;
k=k+1;
end
end
end
set(handles.axes1,'Visible','on');
axes(handles.axes1);imshow(I);title('Query Image');
% --- Executes on button press in pushbutton3.
handles.fq=fq;
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=dir('database');
F=char(F.name);
sz=size(F,1)-3;
h=waitbar(0,'Please wait the system is searching' );
g=[];
for i=1:4
g=[g repmat([i],1,10)];
end
for ff=1:sz
    str=strcat(num2str(ff),'.jpg');
    cd database
    I=imread(str);
    cd ..
I=imresize(I,[256 256]);
I=im2double(I);
k=1;wn={'haar','db2','db4','dmey','bior1.1'};
for w=1:5                      % three wavelets 
for c=1:3                       % three band of colors
    T=I(:,:,c);
for i=1:6                       % six decomposition levels
[a1,b1,c1,d1]=dwt2(T,wn{w});
fv1(k,:)=my_feature(a1);          % extraction of features
T=a1;
k=k+1;
end
end
end
FT{ff}=fv1;
waitbar(ff/sz);
end
close(h);
fq=handles.fq;

for ii=1:length(FT)
    ft=FT{ii};    
    D(ii)=sum(sum(dist(ft(:)',fq(:))))/numel(I);
end
DD=sort(D);
for i=1:10
dx=find(DD(i)==D);
str=strcat(num2str(dx),'.jpg');
cd database
JJ{i}=imread(str);
cd ..
end
axes(handles.axes2);imshow(JJ{2});axes(handles.axes3);imshow(JJ{3});axes(handles.axes4);imshow(JJ{4});
axes(handles.axes5);imshow(JJ{5});axes(handles.axes6);imshow(JJ{6});axes(handles.axes7);imshow(JJ{7});
axes(handles.axes8);imshow(JJ{8});axes(handles.axes9);imshow(JJ{9});axes(handles.axes10);imshow(JJ{10});


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fq=handles.fq;
F=dir('database');
F=char(F.name);
sz=size(F,1)-3;
h=waitbar(0,'Please wait the system is searching' );
g=[];
for i=1:4
g=[g repmat([i],1,10)];
end
for ff=1:sz
    str=strcat(num2str(ff),'.jpg');
    cd database
    I=imread(str);
    cd ..
I=imresize(I,[256 256]);
I=im2double(I);
k=1;wn={'haar','db2','db4','dmey','bior1.1'};
for w=1:5                       % three wavelets 
for c=1:3                       % three band of colors
    T=I(:,:,c);
for i=1:6                       % six decomposition levels
[a1,b1,c1,d1]=dwt2(T,wn{w});
fv1(k,:)=my_feature(a1);          % extraction of features
T=a1;
k=k+1;
end
end
end
FT(ff,:)=fv1(:);
waitbar(ff/sz);
end
close(h);
%====================
net = newff(FT',g,5);
[net,tr] = train(net,FT',g);
%=============
out=round(sim(net,fq(:)));
stt=['The Category of the Image is ', num2str(out)];
set(handles.text2,'String',stt,'FontSize',12,'FontWeight','bold');
