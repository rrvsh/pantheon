{
  xdg.configFile."vlc/vlcrc".text = ''
    [visual] # Visualizer filter
    [glspectrum] # 3D OpenGL spectrum visualization
    [wall] # Wall video filter
    [panoramix] # Panoramix: wall with overlap video filter
    [clone] # Clone video filter
    [yuv] # YUV video output
    [xdg_shell] # XDG shell surface
    [xcb_xv] # XVideo output (XCB)
    [xcb_x11] # X11 video output (XCB)
    [xcb_window] # X11 video window (XCB)
    [wl_shell] # Wayland shell surface
    [vmem] # Video memory output
    [vdummy] # Dummy video output
    [gl] # OpenGL video output
    [flaschen] # Flaschen-Taschen video output
    [fb] # GNU/Linux framebuffer video output
    [transform] # Video transformation filter
    [sharpen] # Sharpen video filter
    [sepia] # Sepia video filter
    [scene] # Scene video filter
    [rotate] # Rotate video filter
    [puzzle] # Puzzle interactive game video filter
    [postproc] # Video post processing filter
    [posterize] # Posterize video filter
    [motionblur] # Motion blur filter
    [mirror] # Mirror video filter
    [hqdn3d] # High Quality 3D Denoiser filter
    [grain] # Grain video filter
    [gradient] # Gradient video filter
    [gradfun] # Gradfun video filter
    [gaussianblur] # Gaussian blur video filter
    [fps] # FPS conversion video filter
    [extract] # Extract RGB component video filter
    [erase] # Erase video filter
    [deinterlace] # Deinterlacing video filter
    [croppadd] # Video cropping filter
    [colorthres] # Color threshold filter
    [canvas] # Canvas video filter
    [bluescreen] # Bluescreen video filter
    [blendbench] # Blending benchmark filter
    [ball] # Ball video filter
    [antiflicker] # antiflicker video filter
    [anaglyph] # Convert 3D picture to anaglyph image video filter
    [alphamask] # Alpha mask video filter
    [adjust] # Image properties filter
    [swscale] # Video scaling filter
    [vaapi_filters] # Video Accelerated API filters
    [svg] # svg
    [freetype] # Freetype2 font renderer
    [stream_out_transcode] # Transcode stream output
    [stats] # Writes statistic info about stream
    [stream_out_standard] # Standard stream output
    [smem] # Stream output to memory buffer
    [setid] # Change the id of an elementary stream
    [stream_out_rtp] # RTP stream output
    [record] # Record stream output
    [mosaic_bridge] # Mosaic bridge stream output
    [es] # Elementary stream output
    [display] # Display stream output
    [delay] # Delay a stream
    [stream_out_chromecast] # Chromecast stream output
    [bridge] # Bridge stream output
    [prefetch] # Stream prefetch filter
    [subsdelay] # Subtitle delay
    [rss] # RSS and Atom feed display
    [remoteosd] # Remote-OSD over VNC
    [mosaic] # Mosaic video sub source
    [marq] # Marquee display
    [logo] # Logo sub source
    [dynamicoverlay] # Dynamic video overlay
    [audiobargraph_v] # Audio Bar Graph Video sub source
    [upnp] # Universal Plug'n'Play
    [sap] # Network streams (SAP)
    [podcast] # Podcasts
    [mpegvideo] # MPEG-I/II video packetizer
    [mux_ts] # TS muxer (libdvbpsi)
    [ps] # PS muxer
    [mux_ogg] # Ogg/OGM muxer
    [mp4] # MP4/MOV muxer
    [avi] # AVI muxer
    [asf] # ASF muxer
    [rtsp] # Legacy RTSP VoD server
    [logger] # File logging
    [gnutls] # GNU TLS transport layer security
    [audioscrobbler] # Submission of played songs to last.fm
    [folder] # Folder meta data
    [lua] # Lua interpreter
    [syslog] # System logger (syslog)
    [file] # File logger
    [console] # Console logger
    [file] # Secrets are stored on a file without any encryption
    [skins2] # Skinnable Interface
    [qt] # Qt interface
    qt-privacy-ask=0
    [ncurses] # Ncurses interface
    [vc1] # VC1 video demuxer
    [ts] # MPEG Transport Stream demuxer
    [subtitle] # Text subtitle parser
    [rawvid] # Raw video demuxer
    [rawdv] # DV (Digital Video) demuxer
    [rawaud] # Raw audio demuxer
    [ps] # MPEG-PS demuxer
    [playlist] # Playlist
    [mp4] # MP4 stream demuxer
    [mod] # MOD demuxer (libmodplug)
    [mkv] # Matroska stream demuxer
    [mjpeg] # M-JPEG camera demuxer
    [image] # Image demuxer
    [h26x] # H264 video demuxer
    [es] # MPEG-I/II/4 / A52 / DTS / MLP audio
    [diracsys] # Dirac video demuxer
    [demuxdump] # File dumper
    [avi] # AVI demuxer
    [avformat] # Avformat demuxer
    [adaptive] # Unified adaptive streaming for DASH/HLS
    [oldrc] # Remote control interface
    [netsync] # Network synchronization
    [motion] # motion control interface
    [gestures] # Mouse gestures control interface
    [vorbis] # Vorbis audio decoder
    [ttml] # TTML subtitles decoder
    [theora] # Theora video decoder
    [telx] # Teletext subtitles decoder
    [svgdec] # SVG video decoder
    [svcdsub] # Philips OGT (SVCD subtitle) decoder
    [subsusf] # USF subtitles decoder
    [subsdec] # Text subtitle decoder
    [spudec] # DVD subtitles decoder
    [speex] # Speex audio decoder
    [schroedinger] # Dirac video decoder using libschroedinger
    [libass] # Subtitle renderers using libass
    [kate] # Kate overlay decoder
    [jpeg] # JPEG image decoder
    [fluidsynth] # FluidSynth MIDI synthesizer
    [dvbsub] # DVB subtitles decoder
    [ddummy] # Dummy decoder
    [cc] # Closed Captions decoder
    [avcodec] # FFmpeg audio/video decoder
    [a52] # ATSC A/52 (AC-3) audio decoder
    [amem] # Audio memory output
    [alsa] # ALSA audio output
    [afile] # File audio output
    [stereo_widen] # Simple stereo widening effect
    [speex_resampler] # Speex resampler
    [spatializer] # Audio Spatializer
    [spatialaudio] # Ambisonics renderer and binauralizer
    [scaletempo] # Audio tempo scaler synched with rate
    [scaletempo_pitch] # Pitch Shifter
    [samplerate] # Secret Rabbit Code (libsamplerate) resampler
    [remap] # Audio channel remapper
    [param_eq] # Parametric Equalizer
    [normvol] # Volume normalizer
    [mono] # Stereo to mono downmixer
    [headphone] # Headphone virtual spatialization effect
    [gain] # Gain control filter
    [equalizer] # Equalizer with 10 bands
    [compressor] # Dynamic range compressor
    [chorus_flanger] # Sound Delay
    [audiobargraph_a] # Audio part of the BarGraph function
    [udp] # UDP stream output
    [access_output_srt] # SRT stream output
    [access_output_rist] # RIST stream output
    [access_output_livehttp] # HTTP Live streaming output
    [http] # HTTP stream output
    [file] # File stream output
    [xcb_screen] # Screen capture (with X11/XCB)
    [vdr] # VDR recordings
    [v4l2] # Video4Linux input
    [udp] # UDP input
    [timecode] # Time code subpicture elementary stream generator
    [smb] # SMB input
    [shm] # Shared memory framebuffer
    [sftp] # SFTP input
    [satip] # SAT>IP Receiver Plugin
    [rtp] # Real-Time Protocol (RTP) input
    [rist] # RIST input
    [live555] # RTP/RTSP/SDP demuxer (using Live555)
    [linsys_hdsdi] # HD-SDI Input
    [libbluray] # Blu-ray Disc support (libbluray)
    [access] # HTTPS input
    [http] # HTTP input
    [ftp] # FTP input
    [filesystem] # File input
    [dvdread] # DVDRead Input (no menu support)
    [dvdnav] # DVDnav Input
    [dvb] # DVB input with v4l2 support
    [dtv] # Digital Television and Radio
    [cdda] # Audio CD input
    [avio] # libavformat AVIO access
    [access_srt] # SRT input
    [access_mms] # Microsoft Media Server (MMS) input
    [imem] # Memory input
    [concat] # Concatenated inputs
    [access_alsa] # ALSA audio capture
    [core] # core program
    metadata-network-access=1
  '';
}
