package shadowland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.shadowland.ShadowLandChapterInfo;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ShadowLandManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class ShadowLandChapterFrame extends Frame
   {
      
      private static var NORMAL:int = 1;
      
      private static var DIFFICULTY:int = 2;
      
      private static var NODE_NUM:int = 6;
      
      private var _mapId:int;
      
      private var _bg:ScaleFrameImage;
      
      private var _leftBg:Bitmap;
      
      private var _normalBtn:SelectedIconButton;
      
      private var _difficultyBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _line:Bitmap;
      
      private var _nodeCon:Component;
      
      private var _backBtn:IconButton;
      
      private var _nodeList:Vector.<ShadowLandNodeItem>;
      
      private var _chapterInfo:ShadowLandChapterInfo;
      
      private var _nodeTempList:Array;
      
      private var _nodePosAry:Array = [[155,20],[295,120],[430,20],[565,110],[690,20],[830,120]];
      
      private var _boxImage:ScaleFrameImage;
      
      private var _starItem:TokenAmountItem;
      
      private var _difficulty:int = 1;
      
      private var _boxState:int = 0;
      
      private var _tempDiff:int = -1;
      
      public function ShadowLandChapterFrame()
      {
         super();
         initView();
         addEvent();
         ShadowLandManager.instance.sendDataRequest();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.bg");
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.ShadowLandChapterFrame.leftBg");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.normalBtn");
         _difficultyBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.difficultyBtn");
         _line = ComponentFactory.Instance.creatBitmap("asset.ShadowLandChapterFrame.line");
         _nodeCon = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.nodeCon");
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.backBtn");
         _boxImage = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.boxImage");
         _starItem = ComponentFactory.Instance.creatComponentByStylename("shadowLandChapterFrame.starItem");
         addToContent(_bg);
         _bg.setFrame(1);
         addToContent(_leftBg);
         addToContent(_normalBtn);
         addToContent(_difficultyBtn);
         addToContent(_line);
         addToContent(_nodeCon);
         addToContent(_backBtn);
         addToContent(_boxImage);
         addToContent(_starItem);
         _boxImage.setFrame(1);
         _boxImage.buttonMode = true;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_normalBtn);
         _btnGroup.addSelectItem(_difficultyBtn);
         _btnGroup.selectIndex = 0;
      }
      
      private function initNodeView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ShadowLandNodeItem = null;
         if(_nodeList && _nodeList.length > 0)
         {
            return;
         }
         _nodeList = new Vector.<ShadowLandNodeItem>();
         _loc2_ = 0;
         while(_loc2_ < NODE_NUM)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("shadowLandChapterFrame.nodeItem");
            _loc1_.x = _loc2_ >= _nodePosAry.length ? 0 : _nodePosAry[_loc2_][0];
            _loc1_.y = _loc2_ >= _nodePosAry.length ? 0 : _nodePosAry[_loc2_][1];
            _nodeCon.addChild(_loc1_);
            _nodeList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _backBtn.addEventListener("click",__backBtnClickHandler);
         _btnGroup.addEventListener("change",__tabChangeHandler);
         MsgMan.addObserver("SHADOWLAND_INFO_UPDATE",this,__updateInfoHandler);
         _boxImage.addEventListener("click",__boxClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _backBtn.removeEventListener("click",__backBtnClickHandler);
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         MsgMan.removeObserver("SHADOWLAND_INFO_UPDATE",this,__updateInfoHandler);
         _boxImage.removeEventListener("click",__boxClickHandler);
      }
      
      private function __boxClickHandler(param1:MouseEvent) : void
      {
         if(_boxState == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ShadowLandChapterFrame.needStarGetReward"));
            return;
         }
         if(_boxState == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ShadowLandChapterFrame.hasGetReward"));
            return;
         }
         ShadowLandManager.instance.sendGetReward(_mapId,_difficulty);
      }
      
      private function __updateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __backBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshInfo() : void
      {
         var _loc1_:Array = model.getChapterInfoByAreaId(_mapId);
         if(_loc1_.length > 0)
         {
            if(_tempDiff > 0)
            {
               _chapterInfo = _loc1_[_tempDiff - 1];
            }
            else
            {
               _chapterInfo = _loc1_[_loc1_.length - 1];
            }
         }
         if(!_chapterInfo)
         {
            return;
         }
         _difficultyBtn.enable = _loc1_.length == DIFFICULTY;
         _btnGroup.selectIndex = _chapterInfo.difficulty - 1;
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ShadowLandNodeItem = null;
         _difficulty = index + 1;
         _chapterInfo = model.getChapterInfoByAreaIdDiff(_mapId,_difficulty);
         if(!_chapterInfo)
         {
            return;
         }
         _bg.setFrame(index + 1);
         initNodeView();
         _nodeTempList = TempleteManager.instance.shadowLandTempCate.getChapterListByAreaIdDiff(_mapId,_difficulty);
         _loc3_ = 0;
         while(_loc3_ < _nodeList.length)
         {
            _loc2_ = _nodeList[_loc3_];
            _loc2_.tempInfo = _nodeTempList[_loc3_];
            _loc2_.refreshView();
            _loc3_++;
         }
         _starItem.firstText = _chapterInfo.passNodeId + "/" + _nodeTempList.length;
         _boxState = model.getBoxStateByIDDiff(_mapId,_difficulty);
         _boxImage.setFrame(_boxState + 1);
         var _loc4_:String = LanguageMgr.GetTranslation("ShadowLandChapterFrame.tip");
         var _loc1_:Array = TempleteManager.instance.shadowLandBoxDropTempCate.getTemplatesByAreaDiff(_mapId,_difficulty);
         _loc4_ += "\n" + GoodsHelp.getRewardDesc3(_loc1_);
         _boxImage.tipData = _loc4_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 1)
         {
            case 0:
               dispose();
         }
      }
      
      private function get index() : int
      {
         if(_btnGroup)
         {
            return _btnGroup.selectIndex;
         }
         return 0;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:Array = null;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            _loc2_ = param1.frameData as Array;
            _mapId = _loc2_[0];
            if(_loc2_[1])
            {
               _tempDiff = _loc2_[1];
            }
            refreshInfo();
            refreshView();
         }
      }
      
      private function get model() : ShadowLandModel
      {
         return ShadowLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_normalBtn);
         _normalBtn = null;
         ObjectUtils.disposeObject(_difficultyBtn);
         _difficultyBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         for each(var _loc1_:ShadowLandNodeItem in _nodeList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _nodeList = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         super.dispose();
         _nodeTempList = null;
         _chapterInfo = null;
      }
   }
}

