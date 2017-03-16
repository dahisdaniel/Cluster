clc;

%initializing fmri software
spm('defaults','fmri');
spm_jobman('initcfg');

%Segmentation to every archive and selecting Save Bias Corrected.

% %1st Archive
matlabbatch{1}.spm.spatial.preproc.channel.vols = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf /PontoNii/20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60; 
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
spm_jobman('run',matlabbatch);

% %2nd Archive
% matlabbatch{1}.spm.spatial.preproc.channel.vols =  {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf /PontoNii/20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'}; 
% matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
% matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
% spm_jobman('run',matlabbatch);

%3rd Archive
% matlabbatch{1}.spm.spatial.preproc.channel.vols = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
% matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
% matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
% spm_jobman('run',matlabbatch);

%4st Archive
% matlabbatch{1}.spm.spatial.preproc.channel.vols = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
% matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
% matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
% spm_jobman('run',matlabbatch);


%5ft Archive
% matlabbatch{1}.spm.spatial.preproc.channel.vols = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
% matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
% matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
% spm_jobman('run',matlabbatch);


%pause

%Coregistration

%1st
matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf /PontoNii/20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf /PontoNii/20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'};
matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
spm_jobman('run',matlabbatch);
% 

%2nd

% matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
% spm_jobman('run',matlabbatch);


%3rd

% matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''}cc;
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
% spm_jobman('run',matlabbatch);

%4st

% matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
% spm_jobman('run',matlabbatch);

%5st

% matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt1mpragesagp2isos108a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'/Users/danieldahis/Documents/Matlab Files/jm_EEBSP5mpg0myOyf (1)/m20161121_133108Headt2spcdaflsagp2isoFSs104a1001.nii,1'};
% matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
% matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
% matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
% spm_jobman('run',matlabbatch);