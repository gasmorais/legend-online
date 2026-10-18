package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TimeVortexEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class TimeVortexAreaView extends Component
   {
      
      private var _map:TimeVortexMapView;
      
      private var _chapterNameBg:Image;
      
      private var _chapterNameImg:ScaleFrameImage;
      
      private var _tipsImg:Image;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _chapterPrevBtn:BaseButton;
      
      private var _chapterNextBtn:BaseButton;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _currentIndex:int;
      
      private var _chapterList:Array;
      
      private var _openLen:int;
      
      public function TimeVortexAreaView()
      {
         super();
         initView();
         addEvent();
         defaultView();
         TimeVortexManager.instance.lookUp();
         TimeVortexManager.instance.lookUpCrack();
      }
      
      private function initView() : void
      {
         _map = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexAreaView.timeVortexMapView");
         _chapterNameBg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.chapterNameBg");
         _chapterNameImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.chapterNameImg");
         _tipsImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.tipsImg");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.tipsTxt");
         _chapterPrevBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.prevChapterBtn");
         _chapterNextBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexAreaView.nextChapterBtn");
         _chapterNameImg.setFrame(1);
         var _loc1_:int = _model.challengeMax - _playerInfo.timeVortexCount;
         _loc1_ = int(_loc1_ > 0 ? _loc1_ : 0);
         _tipsTxt.text = LanguageMgr.GetTranslation("timevortex.view.TimeVortexAreaView.TipsTxt",_loc1_,_model.challengeMax);
         addChild(_map);
         addChild(_chapterNameBg);
         addChild(_chapterNameImg);
         addChild(_tipsImg);
         addChild(_tipsTxt);
         addChild(_chapterPrevBtn);
         addChild(_chapterNextBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeObject(_chapterNameBg);
         _chapterNameBg = null;
         ObjectUtils.disposeObject(_chapterNameImg);
         _chapterNameImg = null;
         ObjectUtils.disposeObject(_tipsImg);
         _tipsImg = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_chapterPrevBtn);
         _chapterPrevBtn = null;
         ObjectUtils.disposeObject(_chapterNextBtn);
         _chapterNextBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _model = null;
         _controller = null;
         _playerInfo = null;
      }
      
      private function addEvent() : void
      {
         _chapterPrevBtn.addEventListener("click",__chapterBtnClickHandler);
         _chapterNextBtn.addEventListener("click",__chapterBtnClickHandler);
         _model.addEventListener("SELECTED_AREA_CHANGE",__areaChangeHandler);
         _model.addEventListener("LAIRD_INFO_CHANGE",__lairdInfoChangeHandler);
         _model.addEventListener("CRACK_INFO_CHANGE",__crackInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_chapterPrevBtn)
         {
            _chapterPrevBtn.removeEventListener("click",__chapterBtnClickHandler);
         }
         if(_chapterNextBtn)
         {
            _chapterNextBtn.removeEventListener("click",__chapterBtnClickHandler);
         }
         if(_model)
         {
            _model.removeEventListener("SELECTED_AREA_CHANGE",__areaChangeHandler);
            _model.removeEventListener("LAIRD_INFO_CHANGE",__lairdInfoChangeHandler);
            _model.removeEventListener("CRACK_INFO_CHANGE",__crackInfoChangeHandler);
         }
      }
      
      private function __lairdInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         refreshView();
      }
      
      private function __crackInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         refreshCrackView();
      }
      
      private function __chapterBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_model.selectedChapter.isAllLoaded())
         {
            return;
         }
         var _loc2_:int = _chapterList.indexOf(_model.selectedChapter);
         switch(param1.target)
         {
            case _chapterPrevBtn:
               if(_loc2_ > 0)
               {
                  _currentIndex = _loc2_ - 1;
                  _model.selectedChapter = _chapterList[_currentIndex];
               }
               break;
            case _chapterNextBtn:
               if(_model.selectedChapter.chapterId < _model.maxChapter.chapterId)
               {
                  _currentIndex = _loc2_ + 1;
                  _model.selectedChapter = _chapterList[_currentIndex];
               }
         }
         _chapterNameImg.setFrame(_currentIndex + 1);
         if(_currentIndex == 0)
         {
            _chapterNameImg.x = 437;
         }
         if(_currentIndex == 1 || _currentIndex == 2 || _currentIndex == 3)
         {
            _chapterNameImg.x = 415;
         }
         if(_currentIndex == 5 || _currentIndex == 6)
         {
            _chapterNameImg.x = 418;
         }
         setBtnState();
      }
      
      private function setBtnState() : void
      {
         _chapterPrevBtn.enable = _currentIndex > 0;
         _chapterNextBtn.enable = _currentIndex < _openLen - 1;
      }
      
      private function __areaChangeHandler(param1:TimeVortexEvent) : void
      {
      }
      
      private function defaultView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _chapterList = _model.selectedLand.chapterDic.getList();
         _chapterList.sort(sortFun);
         _openLen = 0;
         _loc2_ = 0;
         while(_loc2_ < _chapterList.length)
         {
            _loc1_ = int((_chapterList[_loc2_] as CampaignChapterInfo).chapterId);
            if(_loc1_ <= _model.maxChapter.chapterId)
            {
               _openLen = _openLen + 1;
            }
            _loc2_++;
         }
         _model.selectedChapter = _model.recentChapter;
         _currentIndex = _chapterList.indexOf(_model.recentChapter);
         _chapterNameImg.setFrame(_currentIndex + 1);
         if(_currentIndex == 0)
         {
            _chapterNameImg.x = 437;
         }
         if(_currentIndex == 1 || _currentIndex == 2 || _currentIndex == 3)
         {
            _chapterNameImg.x = 415;
         }
         if(_currentIndex == 5 || _currentIndex == 6)
         {
            _chapterNameImg.x = 418;
         }
         setBtnState();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _openLen = 0;
         _loc2_ = 0;
         while(_loc2_ < _chapterList.length)
         {
            _loc1_ = int((_chapterList[_loc2_] as CampaignChapterInfo).chapterId);
            if(_loc1_ <= _model.maxChapter.chapterId)
            {
               _openLen = _openLen + 1;
            }
            _loc2_++;
         }
         _model.selectedChapter = _model.recentChapter;
         _currentIndex = _chapterList.indexOf(_model.recentChapter);
         _chapterNameImg.setFrame(_currentIndex + 1);
         setBtnState();
      }
      
      private function refreshCrackView() : void
      {
         _map.refreshCrackView();
      }
      
      private function sortFun(param1:CampaignChapterInfo, param2:CampaignChapterInfo) : int
      {
         if(param1.chapterId < param2.chapterId)
         {
            return -1;
         }
         if(param1.chapterId > param2.chapterId)
         {
            return 1;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

