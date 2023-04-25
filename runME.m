clearvars
close all;
%% Load data (channels, ap, ap_aoas, RSSI, labels, opt, d1, d2)

CHAN_DATA_DIR = './';
DATASET_NAME = 'channels_jacobs_Jul28.mat';
load(fullfile(CHAN_DATA_DIR, DATASET_NAME));
%% define parameters

D_VALS = -10:0.1:30;
THETA_VALS = -pi/2:0.01:pi/2;
x_len = length(xLabels);
y_len = length(yLabels);
ap_index = 3;

[n_datapoints, n_freq, n_ant, n_ap] = size(channels);
features = zeros(n_datapoints, n_ap, x_len, y_len);
%% generate features

parfor i = 1:n_datapoints
    features(i,:,:,:) = generate_features_from_channel(channels,ap,...
        THETA_VALS,D_VALS,d1,d2,ap_index,opt);
end
