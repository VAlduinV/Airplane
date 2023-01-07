load('simdata.mat','simdata')
load('fltdata.mat','fltdata')
 
h = Aero.Animation;
h.FramesPerSecond = 10;
h.TimeScaling = 5;
idx1 = h.createBody('pa24-250_orange.ac','Ac3d');
idx2 = h.createBody('pa24-250_blue.ac','Ac3d');
 
h.Bodies{2}.TimeSeriesReadFcn = @CustomReadBodyTSData;
h.Bodies{1}.TimeSeriesSource = simdata;
h.Bodies{2}.TimeSeriesSource = fltdata;
h.Bodies{2}.TimeSeriesSourceType = 'Custom';
 
pos1 = h.Bodies{1}.Position;
rot1 = h.Bodies{1}.Rotation;
pos2 = h.Bodies{2}.Position;
rot2 = h.Bodies{2}.Rotation;
 
h.moveBody(1,pos1 + [0 0 -3],rot1);
h.moveBody(2,pos1 + [0 0  0],rot2);
 
patchHandles3 = h.Bodies{2}.PatchHandles;
desiredColor = [1 0 0];
for k = 1:size(patchHandles3,1)
    tempFaceColor = get(patchHandles3(k),'FaceVertexCData');
    tempName = h.Bodies{2}.Geometry.FaceVertexColorData(k).name;
    if ~contains(tempName,'Windshield') &&...
       ~contains(tempName,'front-windows') &&...
       ~contains(tempName,'rear-windows')
    set(patchHandles3(k),...
        'FaceVertexCData',repmat(desiredColor,[size(tempFaceColor,1),1]));
    end
end
 
 
 
h.play();
t = 3;
h.updateBodies(t);
h.updateCamera(t);
