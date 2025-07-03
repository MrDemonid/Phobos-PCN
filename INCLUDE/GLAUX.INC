ifndef @unicode
         auxDIBImageLoad             equ <auxDIBImageLoadA>
         auxDrawStr                  equ <auxDrawStrA>
         auxInitWindow               equ <auxInitWindowA>
         auxRGBImageLoad             equ <auxRGBImageLoadA>
    else
         auxDIBImageLoad             equ <auxDIBImageLoadW>
         auxDrawStr                  equ <auxDrawStrW>
         auxInitWindow               equ <auxInitWindowW>
         auxRGBImageLoad             equ <auxRGBImageLoadW>
endif ; @unicode

procdesc AllocateMemory              :DWORD
procdesc AllocateZeroedMemory        :DWORD
procdesc CleanUp                     
procdesc ComponentFromIndex          :DWORD,:DWORD,:DWORD
procdesc CreateCIPalette             :DWORD
procdesc CreateRGBPalette            :DWORD
procdesc DefaultHandleExpose         :DWORD,:DWORD
procdesc DefaultHandleReshape        :DWORD,:DWORD
procdesc DelayPaletteRealization     
procdesc DestroyThisWindow           :DWORD
procdesc DibNumColors                :DWORD
procdesc FillRgbPaletteEntries       :DWORD,:DWORD,:DWORD
procdesc FindBestPixelFormat         :DWORD,:DWORD,:DWORD
procdesc FindExactPixelFormat        :DWORD,:DWORD,:DWORD
procdesc FindPixelFormat             :DWORD,:DWORD
procdesc FlushPalette                :DWORD,:DWORD
procdesc ForceRedraw                 :DWORD
procdesc FreeMemory                  :DWORD
procdesc GetRegistrySysColors        :DWORD,:DWORD
procdesc GrabStaticEntries           :DWORD
procdesc IsPixelFormatValid          :DWORD,:DWORD,:DWORD
procdesc KeyDown                     :DWORD,:DWORD
procdesc MouseDown                   :DWORD,:DWORD,:DWORD
procdesc MouseLoc                    :DWORD,:DWORD,:DWORD
procdesc MouseUp                     :DWORD,:DWORD,:DWORD
procdesc PixelFormatDescriptorFromDc :DWORD,:DWORD
procdesc RawImageClose               :DWORD
procdesc RawImageGetData             :DWORD,:DWORD
procdesc RawImageGetRow              :DWORD,:DWORD,:DWORD,:DWORD
procdesc RawImageOpenAW              :DWORD,:DWORD
procdesc RealizePaletteNow           :DWORD,:DWORD,:DWORD
procdesc ReleaseStaticEntries        :DWORD
procdesc UpdateStaticMapping         :DWORD
procdesc add3                        :DWORD,:DWORD,:DWORD
procdesc auxCloseWindow              
procdesc auxCreateFont               
procdesc auxDIBImageLoadA            :DWORD
procdesc auxDIBImageLoadW            :DWORD
procdesc auxDrawStrA                 :DWORD
procdesc auxDrawStrAW                :DWORD,:DWORD
procdesc auxDrawStrW                 :DWORD
procdesc auxExposeFunc               :DWORD
procdesc auxGetColorMapSize          
procdesc auxGetDisplayMode           
procdesc auxGetDisplayModeID         
procdesc auxGetDisplayModePolicy     
procdesc auxGetHDC                   
procdesc auxGetHGLRC                 
procdesc auxGetHWND                  
procdesc auxGetMouseLoc              :DWORD,:DWORD
procdesc auxIdleFunc                 :DWORD
procdesc auxInitDisplayMode          :DWORD
procdesc auxInitDisplayModeID        :DWORD
procdesc auxInitDisplayModePolicy    :DWORD
procdesc auxInitPosition             :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxInitWindowA              :DWORD
procdesc auxInitWindowAW             :DWORD,:DWORD
procdesc auxInitWindowW              :DWORD
procdesc auxKeyFunc                  :DWORD,:DWORD
procdesc auxMainLoop                 :DWORD
procdesc auxMouseFunc                :DWORD,:DWORD,:DWORD
procdesc auxQuit                     
procdesc auxRGBImageLoadA            :DWORD
procdesc auxRGBImageLoadW            :DWORD
procdesc auxReshapeFunc              :DWORD
procdesc auxSetFogRamp               :DWORD,:DWORD
procdesc auxSetGreyRamp              
procdesc auxSetOneColor              :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSetRGBMap                :DWORD,:DWORD
procdesc auxSolidBox                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSolidCone                :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSolidCube                :DWORD,:DWORD
procdesc auxSolidCylinder            :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSolidDodecahedron        :DWORD,:DWORD
procdesc auxSolidIcosahedron         :DWORD,:DWORD
procdesc auxSolidOctahedron          :DWORD,:DWORD
procdesc auxSolidSphere              :DWORD,:DWORD
procdesc auxSolidTeapot              :DWORD,:DWORD
procdesc auxSolidTetrahedron         :DWORD,:DWORD
procdesc auxSolidTorus               :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxSwapBuffers              
procdesc auxWireBox                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc auxWireCone                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxWireCube                 :DWORD,:DWORD
procdesc auxWireCylinder             :DWORD,:DWORD,:DWORD,:DWORD
procdesc auxWireDodecahedron         :DWORD,:DWORD
procdesc auxWireIcosahedron          :DWORD,:DWORD
procdesc auxWireOctahedron           :DWORD,:DWORD
procdesc auxWireSphere               :DWORD,:DWORD
procdesc auxWireTeapot               :DWORD,:DWORD
procdesc auxWireTetrahedron          :DWORD,:DWORD
procdesc auxWireTorus                :DWORD,:DWORD,:DWORD,:DWORD
procdesc compareParams               :DWORD,:DWORD,:DWORD
procdesc copy3                       :DWORD,:DWORD
procdesc copymat3                    :DWORD,:DWORD
procdesc crossprod                   :DWORD,:DWORD,:DWORD
procdesc diff3                       :DWORD,:DWORD,:DWORD
procdesc dist3                       :DWORD,:DWORD
procdesc dodecahedron                :DWORD,:DWORD,:DWORD,:DWORD
procdesc dot3                        :DWORD,:DWORD
procdesc doughnut                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc drawbox                     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc drawtriangle                :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc error                       :DWORD
procdesc findList                    :DWORD,:DWORD,:DWORD
procdesc gluCylinder                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc gluNewQuadric               
procdesc gluQuadricDrawStyle         :DWORD,:DWORD
procdesc gluQuadricNormals           :DWORD,:DWORD
procdesc gluSphere                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc icosahedron                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc identifymat3                :DWORD
procdesc initdodec                   
procdesc length3                     :DWORD
procdesc m_popmatrix                 
procdesc m_pushmatrix                
procdesc m_scale                     :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc m_translate                 :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc m_xformpt                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc m_xformptonly               :DWORD,:DWORD
procdesc makeModelPtr                :DWORD,:DWORD,:DWORD
procdesc normalize                   :DWORD
procdesc octahedron                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc pentagon                    :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc perpnorm                    :DWORD,:DWORD,:DWORD,:DWORD
procdesc recorditem                  :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc samepoint                   :DWORD,:DWORD
procdesc scalarmult                  :DWORD,:DWORD,:DWORD,:DWORD
procdesc seterrorfunc                :DWORD
procdesc solidTeapot                 :DWORD,:DWORD,:DWORD
procdesc subdivide                   :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
procdesc tetrahedron                 :DWORD,:DWORD,:DWORD,:DWORD
procdesc tkCloseWindow               
procdesc tkCreateBitmapFont          :DWORD
procdesc tkCreateFilledFont          :DWORD
procdesc tkCreateOutlineFont         :DWORD
procdesc tkCreateStrokeFont          :DWORD
procdesc tkDIBImageLoad              :DWORD
procdesc tkDIBImageLoadAW            :DWORD,:DWORD
procdesc tkDisplayFunc               :DWORD
procdesc tkDrawStr                   :DWORD,:DWORD
procdesc tkErrorPopups               :DWORD
procdesc tkExec                      
procdesc tkExposeFunc                :DWORD
procdesc tkGetColorMapSize           
procdesc tkGetDisplayMode            
procdesc tkGetDisplayModeID          
procdesc tkGetDisplayModePolicy      
procdesc tkGetHDC                    
procdesc tkGetHRC                    
procdesc tkGetHWND                   
procdesc tkGetMouseLoc               :DWORD,:DWORD
procdesc tkIdleFunc                  :DWORD
procdesc tkInitDisplayMode           :DWORD
procdesc tkInitDisplayModeID         :DWORD
procdesc tkInitDisplayModePolicy     :DWORD
procdesc tkInitPosition              :DWORD,:DWORD,:DWORD,:DWORD
procdesc tkInitWindow                :DWORD
procdesc tkInitWindowAW              :DWORD,:DWORD
procdesc tkKeyDownFunc               :DWORD
procdesc tkMouseDownFunc             :DWORD
procdesc tkMouseMoveFunc             :DWORD
procdesc tkMouseUpFunc               :DWORD
procdesc tkQuit                      
procdesc tkRGBImageLoad              :DWORD
procdesc tkRGBImageLoadAW            :DWORD,:DWORD
procdesc tkReshapeFunc               :DWORD
procdesc tkSetFogRamp                :DWORD,:DWORD
procdesc tkSetGreyRamp               
procdesc tkSetOneColor               :DWORD,:DWORD,:DWORD,:DWORD
procdesc tkSetRGBMap                 :DWORD,:DWORD
procdesc tkSwapBuffers               
procdesc tkWndProc                   :DWORD,:DWORD,:DWORD,:DWORD
procdesc wireTeapot                  :DWORD,:DWORD,:DWORD
procdesc xformvec3                   :DWORD,:DWORD,:DWORD
