function varargout = plotCMT(varargin)
% PLOTCMT MATLAB code for plotCMT.fig
%      PLOTCMT, by itself, creates a new PLOTCMT or raises the existing
%      singleton*.
%
%      H = PLOTCMT returns the handle to a new PLOTCMT or the handle to
%      the existing singleton*.
%
%      PLOTCMT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTCMT.M with the given input arguments.
%
%      PLOTCMT('Property','Value',...) creates a new PLOTCMT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotCMT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotCMT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotCMT

% Last Modified by GUIDE v2.5 18-May-2018 12:39:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotCMT_OpeningFcn, ...
                   'gui_OutputFcn',  @plotCMT_OutputFcn, ...
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


% --- Executes just before plotCMT is made visible.
function plotCMT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotCMT (see VARARGIN)

% Choose default command line output for plotCMT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

screensize=get(0,'screensize');
h = get(gcf,'Position');
h = [100 30 h(3:4)]
set(gcf,'Position',h)

set(handles.plotfigure,'visible','off')
% UIWAIT makes plotCMT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotCMT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
axis off 


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=getframe(handles.plotfigure);
imwrite(h.cdata,'CMT.png');
errordlg('Finished','warn');

% --- Executes on button press in huitu.
function huitu_Callback(hObject, eventdata, handles)
% hObject    handle to huitu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset
axes(handles.plotfigure);
if isempty(get(handles.strike,'String')) || isempty(get(handles.dip,'String')) || isempty(get(handles.slip,'String'))
   set(handles.plotfigure,'visible','off')
   errordlg('wrong!','warn');
else   
    stk=str2double(get(handles.strike,'String'));
    dip=str2double(get(handles.dip,'String'));
    slip=str2double(get(handles.slip,'String'));
   
    epi=[0 0];
    faultp=[stk dip slip];
    lu=-1;es=1;
    [mom1]=dctomt(faultp);%moment tensors
    [tbpvec,tbpval]=foreigen(mom1);
    colorface='r'; rad=1;
    cldraw(rad,[0 0],0.5,[0.99 0.99 0.99],1,epi);  
    dcplane(rad,tbpvec,lu,es,colorface,epi);
    axis([-1.1 1.1 -1.1 1.1])
    showaxes('hide')   
end

function strike_Callback(hObject, eventdata, handles)
% hObject    handle to strike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of strike as text
%        str2double(get(hObject,'String')) returns contents of strike as a double


% --- Executes during object creation, after setting all properties.
function strike_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dip_Callback(hObject, eventdata, handles)
% hObject    handle to dip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dip as text
%        str2double(get(hObject,'String')) returns contents of dip as a double


% --- Executes during object creation, after setting all properties.
function dip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slip_Callback(hObject, eventdata, handles)
% hObject    handle to slip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slip as text
%        str2double(get(hObject,'String')) returns contents of slip as a double


% --- Executes during object creation, after setting all properties.
function slip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outputTXT_Callback(hObject, eventdata, handles)
% hObject    handle to outputTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputTXT as text
%        str2double(get(hObject,'String')) returns contents of outputTXT as a double


% --- Executes during object creation, after setting all properties.
function outputTXT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
