var y=Object.defineProperty;var n=(m,t)=>y(m,"name",{value:t,configurable:!0});const p={},_={};p["doctor.DoctorFrame"]=n(function(t){const a=t.C("com.pickgliss.ui.controls.Frame");class i extends a{static{n(this,"__DoctorFrame")}static $fields(e){e._minBtn=null,e._back1=null,e._back2=null,e._startDocBtn=null,e._copyBtn=null,e._decTxt=null,e._vbox=null,e._scrollPanel=null,e._itemList=null,e._copyText=null,e._resuleTxt=""}constructor(){super(),this.initView(),this.initEvent()}initView(){this._back1=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Back1"),this._back2=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Back2"),this._startDocBtn=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.StartBtn"),this._copyBtn=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.CopyBtn"),this._decTxt=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Describetxt"),this._vbox=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.Vbox"),this._scrollPanel=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.ScrollPanel"),this._minBtn=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.MinBtn"),this.addToContent(this._back1),this.addToContent(this._back2),this.addToContent(this._startDocBtn),this.addToContent(this._copyBtn),this.addToContent(this._decTxt),this.addToContent(this._scrollPanel),this.addToContent(this._minBtn),this._scrollPanel.setView(this._vbox),this._scrollPanel.vUnitIncrement=58,this._copyText=new(t.C("flash.text.TextField")),this._copyText.multiline=!0,this._decTxt.htmlText="<font color='#36ff00'>Clique em </font><font color='#ffcd63'>Iniciar Diagn\xF3stico</font><font color='#36ff00'> para iniciar diagn\xF3stico de carregamento.</font>",this._startDocBtn.enable=!1,this._copyBtn.visible=!1,this.titleText="Diagn\xF3stico do Legend Online"}initEvent(){this._minBtn.addEventListener("click",t.bind(this,"__minHandler")),this._startDocBtn.addEventListener("click",t.bind(this,"__clickHandler")),this._copyBtn.addEventListener("click",t.bind(this,"__clickHandler")),this.addEventListener("response",t.bind(this,"__frameResponseHandler")),this.addEventListener("addedToStage",t.bind(this,"__addToStageHandler"))}removeEvent(){this._minBtn.removeEventListener("click",t.bind(this,"__minHandler")),this._startDocBtn.removeEventListener("click",t.bind(this,"__clickHandler")),this._copyBtn.removeEventListener("click",t.bind(this,"__clickHandler")),this.removeEventListener("response",t.bind(this,"__frameResponseHandler")),this.removeEventListener("addedToStage",t.bind(this,"__addToStageHandler"))}__minHandler(e){this.dispatchEvent(new(t.C("flash.events.Event"))("min",!1,!1))}__addToStageHandler(e){this.removeEventListener("addedToStage",t.bind(this,"__addToStageHandler")),t.C("flash.system.Security").loadPolicyFile(t.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH+"crossdomain.xml"),this.getSystemType(),this.getBrowerType(),this.tryCrossDomain(),this.refreshLoaderList()}__clickHandler(e){e.currentTarget==this._startDocBtn?(this._startDocBtn.visible=!1,this._copyBtn.enable=!1,this._copyBtn.visible=!0,this.startCheck()):this.copyResule()}__frameResponseHandler(e){switch(e.responseCode){case 0:this.dispose();break;case 1:this.dispose()}}startCheck(){this.loadNext()}getSystemType(){var e=t.C("flash.system.Capabilities").os,s=t.C("flash.system.Capabilities").version,o=t.C("flash.system.Capabilities").playerType;this._resuleTxt+="Sistema: "+e+".<br>Vers\xE3o do FlashPlayer:  "+s+".<br>Tipo do FlashPlayer: "+o+".<br>"}getBrowerType(){var e=null;try{e=t.C("manager.ExternalInterfaceManager").instance.getBrowerType(),e?this._resuleTxt+="Informa\xE7\xF5es do Navegador: "+e+".<br>":this._resuleTxt+="Informa\xE7\xF5es do Navegador: Outros.<br>"}catch{}}tryCrossDomain(){var e=new(t.C("flash.net.URLLoader"));e.addEventListener("ioError",t.bind(this,"connectCrossDomainIOError")),e.addEventListener("init",t.bind(this,"connectCrossDomainProgress")),e.addEventListener("securityError",t.bind(this,"connectCrossDomainSecurityError")),e.load(new(t.C("flash.net.URLRequest"))(t.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH+"crossdomain.xml"))}connectCrossDomainIOError(e){this._resuleTxt+="Lendo "+t.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH+"crossdomain.xml erro IO;<br>"}connectCrossDomainProgress(e){this._resuleTxt+="Lendo "+t.C("com.pickgliss.ui.ComponentSetting").RESOURCE_PATH+"Sucedido.<br>"}connectCrossDomainSecurityError(e){this._resuleTxt+="Lendo erro de sandbox crossdomain.xml.<br>",this._decTxt.htmlText="<font color='#FF0000'>Lendo erro sandbox crossdomain.xml</font>"}refreshLoaderList(){var e=null,s=null,o=1;this._itemList=[];for(var l in t.C("com.pickgliss.ui.ComponentSetting").checkMD5)e=t.C("com.pickgliss.ui.ComponentSetting").getMD5FileNameByFilePath(l),s=new(t.C("doctor.view.LoaderInfoItem"))(o+" . "+e,l),this._vbox.addChild(s),this._itemList.push(s),o++;this._scrollPanel.invalidateViewport(),this._startDocBtn.enable=!0}loadNext(){var e=null;this._itemList.length>0?(e=this._itemList.shift(),e.start(t.bind(this,"checkComplete")),e.y>e.viewRectangle.height*10&&(this._scrollPanel.vScrollbar.scrollValue=e.y-e.viewRectangle.height*9)):(this._copyBtn.enable=!0,this._decTxt.y-=5,this._decTxt.htmlText="Verifica\xE7\xE3o dos documentos conclu\xEDda, caso tenha aviso de erro, copie, salve e envie ao nosso SAC. <br>Caso verifica\xE7\xE3o seja conclu\xEDda, limpe cache do navegador e entre no jogo novamente.")}checkComplete(e){e!=null&&typeof e!="string"&&(e=String(e)),this._resuleTxt+="Arquivo"+e+".<br>",this.loadNext()}copyResule(){this._copyText.htmlText=this._resuleTxt,t.C("flash.system.System").setClipboard(this._copyText.text),this._decTxt.text="Copiado com sucesso"}dispose(){if(!this.isDie){this.removeEvent();for(var e of t.values(this._itemList))e.stop(),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(e);t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back1),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back2),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._startDocBtn),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._decTxt),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._copyBtn),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._copyText),this._back1=null,this._back2=null,this._startDocBtn=null,this._copyBtn=null,this._decTxt=null,this._itemList=null,this._copyText=null,this._resuleTxt=null,super.dispose()}}}return t.meta(i,"doctor.DoctorFrame",[]),i},"define"),_["doctor.DoctorFrame"]=["com.pickgliss.ui.ComponentFactory","com.pickgliss.ui.ComponentSetting","com.pickgliss.ui.controls.Frame","com.pickgliss.utils.ObjectUtils","doctor.view.LoaderInfoItem","flash.events.Event","flash.net.URLLoader","flash.net.URLRequest","flash.system.Capabilities","flash.system.Security","flash.system.System","flash.text.TextField","manager.ExternalInterfaceManager"],p["doctor.DoctorStyle"]=n(function(t){const a=t.Object;class i extends a{static{n(this,"__DoctorStyle")}static $fields(e){}constructor(){super();var e=t.XML(`<xml name="doctorstyle">
				<set type="flash.text.TextFormat" stylename="doctor.FrameTitleText_t" args="Arial,15,0xFFDD83,true" letterSpacing="0"/>
				<set type="flash.text.TextFormat" stylename="doctor.Describetxt_t" args="Arial,12,0xffffff," letterSpacing="0"/>
				<set type="flash.text.TextFormat" stylename="doctor.LoaderItemResule_t" args="Arial,12,0xffffff,,,,,,left" letterSpacing="0"/>
			
				<set type="flash.filters.GlowFilter" stylename="doctor.FrameTitile_g" args="0x000000,1,5,5,5" />
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.DefaultFilter" args="1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0" />
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.LightFilter" args="1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0"/>
				<set type="flash.filters.ColorMatrixFilter" stylename="doctor.GrayFilter" args="0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0"/>
				<set type="flash.filters.GlowFilter" stylename="doctor.normal_f" args="0x000000,1,5,5,3" />		
		
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.FrameTitleText" 
					textFormatStyle="doctor.FrameTitleText_t" filterString="doctor.FrameTitile_g" 
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.CloseBtn" 
					backStyle="asset.core.closeBtn_style01" filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					displacement='false' isFollowMouse = "false"
				/>
				<component classname="com.pickgliss.ui.image.Scale9CornerImage" stylename="doctor.FrameBackgoundBase1" 
					resourceLink="asset.core.framestyle03_scale9bg1,asset.core.framestyle03_scale9bg2,asset.core.framestyle03_scale9bg3,asset.core.framestyle03_scale9bg4,asset.core.framestyle03_scale9bg5,asset.core.framestyle03_scale9bg6,asset.core.framestyle03_scale9bg7,asset.core.framestyle03_scale9bg8,asset.core.framestyle03_scale9bg9"
				/>
				<component classname="com.pickgliss.ui.image.Image" stylename="doctor.FrameTitleImage1" 
					resourceLink="asset.core.frameTitleImage2"
					width="229" height="17"
				/>
				<component classname="com.pickgliss.ui.image.MutipleImage" stylename="doctor.FrameBg1"
					resourceLink="doctor.FrameBackgoundBase1,doctor.FrameTitleImage1" imageRectString="-18|-15|0|23|0,232|17|-4|0|9" 
				/>
				<component classname="doctor.DoctorFrame" stylename="doctor.DoctorFrame"
					closestyle="doctor.CloseBtn" titleStyle="doctor.FrameTitleText" backStyle="doctor.FrameBg1" 
					closeInnerRectString="29,-31,-13,29,14" 
					moveInnerRectString="0,80,0,25,1" titleOuterRectPosString="0,-5,1"
					moveEnable="false" enterEnable="true" escEnable="true"
					containerX="-6" containerY="8"
					width="513" height="392"
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.MinBtn" 
					backStyle="asset.loading.DoctorMinBtn"  displacement="false"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					width="29" height="29"	x="486" y="-22"
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Back1" 
					resourceLink="asset.core.describeBackground_style06" scaleGridString="10,10,70,30"
					width="528" height="300" x="-2" y="4" 
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Back2" 
					resourceLink="asset.core.InputBack_Style_01" scaleGridString="10,10,125,7"
					width="530" height="48" x="-3" y="304"
				/>
				<component classname="com.pickgliss.ui.controls.IconButton" stylename="doctor.CopyBtn" 
					backStyle="asset.core.ButtonStyle_03" 
					iconStyle="asset.loading.DoctorCopy" iconInnerRectString="32,48,10,22,13"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					x="407" y="308"
				/>
				<component classname="com.pickgliss.ui.controls.IconButton" stylename="doctor.StartBtn" 
					backStyle="asset.core.ButtonStyle_03" 
					iconStyle="asset.loading.DoctorStart" iconInnerRectString="18,77,10,22,13"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					x="407" y="308"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.Describetxt" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					wordWrap="true" multiline="true" width="392" height="40" x="4" y="318"
				/>
				<component classname="com.pickgliss.ui.image.Image" stylename="doctor.LoaderItemBack"
					resourceLink="asset.loading.Spliceline"
					width="495" height="30"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemName" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="170" height="22" x="10" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemProgress" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="145" height="22" x="160" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemSpeed" 
					textFormatStyle="doctor.Describetxt_t" filterString="doctor.normal_f" autoSize="none"
					width="142" height="22" x="280" y="6"
				/>
				<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="doctor.LoaderItemResule" 
					textFormatStyle="doctor.LoaderItemResule_t" filterString="doctor.normal_f" autoSize="none"
					width="144" height="22" x="345" y="6" isAutoFitLength="true"
				/>			
				<component classname="com.pickgliss.ui.controls.container.VBox" stylename="doctor.Vbox"
					spacing="0"
				/>	
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.Scrollbar02_Back" 
					resourceLink="asset.core.scrollbar02_bg" 
					width="15" height="24" 
				/>
				<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="doctor.scrollbar02_stepAsset" 
					resourceLink="asset.core.scrollbar02_step" scaleGridString="0,18,21,36"
					width="21" height="56"
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Step" 
					backStyle="doctor.scrollbar02_stepAsset" displacement="false"
					filterString="doctor.DefaultFilter,doctor.LightFilter,doctor.DefaultFilter,doctor.GrayFilter"
					width="21" height="56" 
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Up" 
					backStyle="asset.core.scrollbar02_up" displacement="false"
					width="11" height="10"	
				/>
				<component classname="com.pickgliss.ui.controls.BaseButton" stylename="doctor.Scrollbar02_Down" 
					backStyle="asset.core.scrollbar02_down"  displacement="false"
					width="11" height="10"	
				/>
				<component classname="com.pickgliss.ui.controls.Scrollbar" stylename="doctor.VScrollbar02" 
					trackStyle="doctor.Scrollbar02_Back" 
					thumbStyle="doctor.Scrollbar02_Step" 
					decreaseButtonStyle="doctor.Scrollbar02_Up" 
					increaseButtonStyle="doctor.Scrollbar02_Down" 
					trackInnerRectString="3,3,0,0,0" 
					thumbAreaInnerRectString="0,0,10,10,0" 
					decreaseButtonInnerRectString="10,10,0,0,9" 
					increaseButtonInnerRectString="10,10,0,0,10" 
					orientation="0" thumbMinSize="38" 
					width="21" height="200" 
				/>
				<component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="doctor.ScrollPanel"
					vScrollbarStyle="doctor.VScrollbar02"
					vScrollbarInnerRectString="21,0,0,0,3"
					viewportInnerRectString="0,22,0,0,0" 
					vScrollProxy='0'
					x="1" y="7" width="524" height="290" 
				/>
			</xml>`);t.C("com.pickgliss.ui.ComponentFactory").Instance.setup(e)}}return t.meta(i,"doctor.DoctorStyle",[]),i},"define"),_["doctor.DoctorStyle"]=["com.pickgliss.ui.ComponentFactory"],p["doctor.view.LoaderInfoItem"]=n(function(t){const a=t.C("flash.display.Sprite");class i extends a{static{n(this,"__LoaderInfoItem")}static $fields(e){e._back=null,e._loaderName=null,e._loaderProgress=null,e._loaderSpeed=null,e._resule=null,e._path=null,e._name=null,e._startTime=0,e._completeBack=null,e._loader=null,e._request=null}constructor(e,s){super(),this._path=s,this._name=e,this._loader=new(t.C("flash.net.URLLoader")),this.initView(),this.initEvent()}get viewRectangle(){return new(t.C("flash.geom.Rectangle"))(0,0,507,29)}initView(){this._back=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemBack"),this._loaderName=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemName"),this._loaderProgress=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemProgress"),this._loaderSpeed=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemSpeed"),this._resule=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("doctor.LoaderItemResule"),this.addChild(this._back),this.addChild(this._loaderName),this.addChild(this._loaderProgress),this.addChild(this._loaderSpeed),this.addChild(this._resule),this._loaderName.text=this._name,this._loaderProgress.text="Progresso: Aguardando..."}initEvent(){this._loader.addEventListener("complete",t.bind(this,"__onDataLoadComplete")),this._loader.addEventListener("progress",t.bind(this,"__onProgress")),this._loader.addEventListener("httpStatus",t.bind(this,"__onStatus")),this._loader.addEventListener("ioError",t.bind(this,"__onIOError"))}removeEvent(){this._loader.removeEventListener("complete",t.bind(this,"__onDataLoadComplete")),this._loader.removeEventListener("progress",t.bind(this,"__onProgress")),this._loader.removeEventListener("httpStatus",t.bind(this,"__onStatus")),this._loader.removeEventListener("ioError",t.bind(this,"__onIOError"))}start(e){this._completeBack=e,this._startTime=t.C("flash.utils.getTimer")();var s=new(t.C("flash.net.URLVariables"));s.ran=Math.random(),this._loader.dataFormat="binary",this._request=new(t.C("flash.net.URLRequest"))(this._path),this._request.method="GET",this._request.data=s,this._loader.load(this._request)}stop(){this.removeEvent();try{this._loader.close()}catch{}}__onStatus(e){}__onIOError(e){}__onDataLoadComplete(e){this.removeEvent(),this._loaderProgress.text="Progresso: 100%";var s=this._loader.bytesTotal*1e3/((t.C("flash.utils.getTimer")()-this._startTime)*1024);s>1e3?this._loaderSpeed.text=(s/1024).toFixed(2)+"MB/s":this._loaderSpeed.text=s.toFixed(2)+"KB/s",this._resule.text="Verificando arquivo...";try{this._loader.close()}catch{}if(this._loader.data.length==0){this._completeBack("Arquivo"+this._path+"Extens\xE3o \xE9 zero"),this._completeBack=null;return}this.check(t.as(this._loader.data,t.C("flash.utils.ByteArray")))}__onProgress(e){var s=(e.bytesLoaded/e.bytesTotal*100).toFixed(2);this._loaderProgress.text="Progresso\uFF1A"+s+"%",this._resule.text="Carregando arquivo..."}check(e){var s=t.C("com.pickgliss.ui.ComponentSetting").getUrlMd5(this._path);t.C("com.pickgliss.ui.ComponentSetting").checkNeedAnalyzeMd5(s)?t.C("com.pickgliss.ui.ComponentSetting").compareMD5(e,s)?(this._completeBack("Arquivo"+this._path+"Sucedido"),this._resule.text="Verifica\xE7\xE3o do arquivo sucedido"):(this._completeBack("Arquivo"+this._path+"Falha"),this._resule.text="Falha na verifica\xE7\xE3o do arquivo"):(this._completeBack("Arquivo"+this._path+"Falha"),this._resule.text="Falha na verifica\xE7\xE3o do arquivo")}dispose(){this.removeEvent(),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderName),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderProgress),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._loaderSpeed),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resule),this._back=null,this._loaderName=null,this._loaderProgress=null,this._loaderSpeed=null,this._resule=null,this._path=null}set viewRectangle(e){super.viewRectangle=e}}return t.meta(i,"doctor.view.LoaderInfoItem",["Disposeable","IManualSize"]),i},"define"),_["doctor.view.LoaderInfoItem"]=["com.pickgliss.ui.ComponentFactory","com.pickgliss.ui.ComponentSetting","com.pickgliss.utils.ObjectUtils","flash.display.Sprite","flash.geom.Rectangle","flash.net.URLLoader","flash.net.URLRequest","flash.net.URLVariables","flash.utils.ByteArray","flash.utils.getTimer"],p["notice.NoticeFrame"]=n(function(t){const a=t.C("com.pickgliss.ui.controls.Frame");class i extends a{static{n(this,"__NoticeFrame")}static $fields(e){e._back=null,e._scrollPanel=null,e._content=null,e._updateTitleBg=null,e._updateContent=null,e._dateAsset=null,e._updateDate=null,e._updatePreTitleBg=null,e._updatePre=null,e._titleSp1=null,e._titleSp2=null,e._contain=null,e._itemArr1=null,e._itemArr2=null,e._loader=null,e.xml=null}constructor(){super()}load(){this._loader||(this._loader=new(t.C("flash.net.URLLoader"))),this._loader.dataFormat="text";var e=new(t.C("flash.net.URLVariables"));e.rnd=Math.random();var s=new(t.C("flash.net.URLRequest"))(t.C("com.pickgliss.ui.ComponentSetting").VERTION_PATH);s.data=e,this._loader.addEventListener("complete",t.bind(this,"__completehandler")),this._loader.load(s)}__completehandler(e){this.isDie||(this.xml=t.XML(t.as(e.currentTarget,t.C("flash.net.URLLoader")).data),e.currentTarget.removeEventListener("complete",t.bind(this,"__completehandler")),this.initView(),this.refreshView(),this.initEvent())}initView(){this.titleText="An\xFAncio de Atualiza\xE7\xE3o",this._back=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("noticeFrame.UpdateBroadCastBack"),this._scrollPanel=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastScroll"),this._updateDate=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastDate"),this._dateAsset=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateDateAsset"),this._updateTitleBg=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateTitleBg"),this._updateContent=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateContentAsset"),this._updatePre=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdatePreAsset"),this._updatePreTitleBg=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.broadcast.UpdateTitleBg"),this._contain=new(t.C("com.pickgliss.ui.controls.container.VBox")),this._contain.spacing=10,this.addToContent(this._back),this.addToContent(this._scrollPanel),this._titleSp1=new(t.C("flash.display.Sprite")),this._titleSp2=new(t.C("flash.display.Sprite")),this._itemArr1=[],this._itemArr2=[],this._titleSp1.addChild(this._updateTitleBg),this._titleSp1.addChild(this._updateContent),this._titleSp1.addChild(this._dateAsset),this._titleSp1.addChild(this._updateDate),this._titleSp2.addChild(this._updatePreTitleBg),this._titleSp2.addChild(this._updatePre),this._scrollPanel.setView(this._contain)}initEvent(){this.addEventListener("response",t.bind(this,"__frameResponseHandler"))}removeEvent(){this.removeEventListener("response",t.bind(this,"__frameResponseHandler")),this._loader&&this._loader.removeEventListener("complete",t.bind(this,"__completehandler"))}__frameResponseHandler(e){switch(e.responseCode){case 0:this.dispose();break;case 1:this.dispose()}}get viewRectangle(){return new(t.C("flash.geom.Rectangle"))(0,0,635,407)}refreshView(){var e=null,s=null,o=null,l=null,d=null,h=null;if(this.xml){try{this._updateDate.text=this.xml.$descendants("time")[0].toString()}catch{e="N\xE3o h\xE1 comunicado de atualiza\xE7\xE3o",this.dispose();return}var r="",c="",g=/\/n/g;for(s of t.values(this.xml.curContent.$descendants("item")))s&&(o=new(t.C("flash.display.Sprite"))),l=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("timestory.UpdateBroadCastContent"),this.isNullOrEmpty(s.content.text())?this.isNullOrEmpty(s.title.text())||(r="<font color='#fef347'><textformat leading='7px'>"+s.title.text()+`</textformat></font>
`):(this.isNullOrEmpty(s.title.text())||(r="<font color='#fef347'><textformat leading='7px'>"+s.title.text()+`</textformat></font>
`),r=r+"<font color='#e4d9ba'><textformat leading='7px' blockIndent='13em'>"+s.content.text()+`</textformat></font>
`),r=r.replace(g,"<br/>"),l.htmlText=r,l.height=l.textHeight+4,o.addChild(l),this._itemArr1.push(o);if(!this.isNullOrEmpty(r)){this._contain.addChild(this._titleSp1);for(o of t.values(this._itemArr1))this._contain.addChild(o)}for(s of t.values(this.xml.nextContent.$descendants("item")))s&&(d=new(t.C("flash.display.Sprite"))),h=t.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("timestory.UpdateBroadCastContent"),this.isNullOrEmpty(s.content.text())?this.isNullOrEmpty(s.title.text())||(c="<font color='#fef347'><textformat leading='7px'>"+s.title.text()+`</textformat></font>
`):(this.isNullOrEmpty(s.title.text())||(c="<font color='#fef347'><textformat leading='7px'>"+s.title.text()+`</textformat></font>
`),c=c+"<font color='#e4d9ba'><textformat leading='7px' blockIndent='13em'>"+s.content.text()+`</textformat></font>
`),c=c.replace(g,"<br/>"),h.htmlText=c,h.height=h.textHeight+4,d.addChild(h),this._itemArr2.push(d);if(!this.isNullOrEmpty(c)){this._contain.addChild(this._titleSp2);for(d of t.values(this._itemArr2))this._contain.addChild(d)}this._scrollPanel.invalidateViewport()}}isNullOrEmpty(e){return e!=null&&typeof e!="string"&&(e=String(e)),e==null||e==""}dispose(){this.removeEvent(),t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back),this._back=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel),this._scrollPanel=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dateAsset),this._dateAsset=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updateDate),this._updateDate=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updateContent),this._updateContent=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updatePre),this._updatePre=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleSp1),this._titleSp1=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleSp2),this._titleSp2=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemArr1),this._itemArr1=null,t.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemArr2),this._itemArr2=null,super.dispose()}set viewRectangle(e){super.viewRectangle=e}}return t.meta(i,"notice.NoticeFrame",["IManualSize"]),i},"define"),_["notice.NoticeFrame"]=["com.pickgliss.ui.ComponentFactory","com.pickgliss.ui.ComponentSetting","com.pickgliss.ui.controls.Frame","com.pickgliss.ui.controls.container.VBox","com.pickgliss.utils.ObjectUtils","flash.display.Sprite","flash.geom.Rectangle","flash.net.URLLoader","flash.net.URLRequest","flash.net.URLVariables"],p["notice.NoticeStyle"]=n(function(t){const a=t.Object;class i extends a{static{n(this,"__NoticeStyle")}static $fields(e){}constructor(){super();var e=t.XML(`<xml name="noticestyle">
							<set type="flash.text.TextFormat" stylename="notice.FrameTitleText_t" args="Arial,15,0xFFDD83,true" letterSpacing="2"/>
							<set type="flash.text.TextFormat" stylename="notice.Describetxt_t" args="Arial,12,0xffffff," letterSpacing="2"/>
							<set type="flash.text.TextFormat" stylename="notice.UpdateBroadCastDate_t" args="Arial,14,0xffeb79,,,,,,left"  letterSpacing="1"/>
							<set type="flash.filters.GlowFilter" stylename="notice.FrameTitile_g" args="0x000000,1,5,5,5" />
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.DefaultFilter" args="1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0" />
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.LightFilter" args="1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0"/>
							<set type="flash.filters.ColorMatrixFilter" stylename="notice.GrayFilter" args="0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0"/>
							<set type="flash.filters.GlowFilter" stylename="notice.normal_f" args="0x000000,1,5,5,3" />		
					
							<component classname="com.pickgliss.ui.text.FilterFrameText" stylename="notice.FrameTitleText" 
								textFormatStyle="notice.FrameTitleText_t" filterString="notice.FrameTitile_g" 
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.CloseBtn" 
								backStyle="asset.core.closeBtn_style01" filterString="notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter"
								displacement='false' isFollowMouse = "false"
							/>
							<component classname="com.pickgliss.ui.image.Scale9CornerImage" stylename="notice.FrameBackgoundBase1" 
                                resourceLink="asset.core.style02_scale9bg1,asset.core.style02_scale9bg2,asset.core.style02_scale9bg3,asset.core.style02_scale9bg4,asset.core.style02_scale9bg5,asset.core.style02_scale9bg6,asset.core.style02_scale9bg7,asset.core.style02_scale9bg8,asset.core.style02_scale9bg9"
							/>
							<component classname="com.pickgliss.ui.image.Image" stylename="notice.FrameTitleImage1" 
								resourceLink="asset.core.frameTitleImage2"
								width="229" height="17"
							/>
							<component classname="com.pickgliss.ui.image.MutipleImage" stylename="notice.FrameBg1"
								resourceLink="notice.FrameBackgoundBase1" imageRectString="-18|-15|0|23|0" 
							/>
							<component classname="notice.NoticeFrame" stylename="notice.NoticeFrame"
								closestyle="notice.CloseBtn" titleStyle="notice.FrameTitleText" backStyle="notice.FrameBg1" 
								closeInnerRectString="29,3,12,29,14" 
								moveInnerRectString="0,30,0,45,1" titleOuterRectPosString="0,12,1"
								moveEnable="false" enterEnable="true" escEnable="true"
								containerX="8" containerY="45"
								width="635" height="407"
							/>
                            <custom classname="asset.timestory.UpdateBroadCastBack" stylename="noticeFrame.UpdateBroadCastBack" 
                                x='0' y="0" width="618" height="324"
                            />
                            <component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="noticeFrame.UpdateBroadCastScroll" 
			                    vScrollbarStyle="notice.VScrollbar03"
			                    vScrollbarInnerRectString="16,0,0,0,3"
			                    viewportInnerRectString="0,0,0,0,5"
			                    vScrollProxy="0" vUnitIncrement="5"
			                    width="618" height="324"
		                    />
							<component classname="com.pickgliss.ui.controls.Scrollbar" stylename="notice.VScrollbar03" 
								trackStyle="notice.Scrollbar03_Back" 
								thumbStyle="notice.Scrollbar03_Step" 
								decreaseButtonStyle="notice.Scrollbar03_Up" 
								increaseButtonStyle="notice.Scrollbar03_Down" 
                                trackInnerRectString="0,0,0,0,0" 
			                    thumbAreaInnerRectString="1,1,16,16,0" 
			                    decreaseButtonInnerRectString="16,16,0,0,9" 
			                    increaseButtonInnerRectString="16,16,0,0,10" 
			                    orientation="0" thumbMinSize="23" 
			                    width="16" height="200" 
							/>
							<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="notice.Scrollbar03_Back" 
								resourceLink="asset.core.scrollbar03_bg" 
								width="15" height="24" 
							/>
							<component classname="com.pickgliss.ui.image.ScaleBitmapImage" stylename="notice.scrollbar03_stepAsset" 
								resourceLink="asset.core.scrollbar03_step" scaleGridString="0,13,13,26"
								width="13" height="36"
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Step" 
								backStyle="notice.scrollbar03_stepAsset" displacement="false"
								filterString="notice.DefaultFilter,notice.LightFilter,notice.DefaultFilter,notice.GrayFilter"
								width="13" height="36" 
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Up" 
								backStyle="asset.core.scrollbar03_up" displacement="false"
								width="16" height="16"	
							/>
							<component classname="com.pickgliss.ui.controls.BaseButton" stylename="notice.Scrollbar03_Down" 
								backStyle="asset.core.scrollbar03_down"  displacement="false"
								width="16" height="16"	
							/>
							<component classname="com.pickgliss.ui.controls.ScrollPanel" stylename="notice.ScrollPanel"
								vScrollbarStyle="notice.VScrollbar02"
								vScrollbarInnerRectString="21,0,0,0,3"
								viewportInnerRectString="0,22,0,0,0" 
								vScrollProxy='0'
								x="1" y="7" width="524" height="290" 
							/>
					        <component classname="com.pickgliss.ui.text.FilterFrameText" stylename="noticeFrame.UpdateBroadCastDate"	
								textFormatStyle="notice.UpdateBroadCastDate_t" filterString="notice.normal_f"
								autoSize="none"  width="220" height="20"
								x="345" y="7"
 							/>
						</xml>`);t.C("com.pickgliss.ui.ComponentFactory").Instance.setup(e)}}return t.meta(i,"notice.NoticeStyle",[]),i},"define"),_["notice.NoticeStyle"]=["com.pickgliss.ui.ComponentFactory"];export{p as defs,_ as deps};
