package childspiritexpedition
{
   import childspiritexpedition.formation.SpiritExpeditionNSHeadItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionChapterInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SpiritExpeditionChapterFrame extends Frame
   {
      
      private var _line:Bitmap;
      
      private var _rightBg:MutipleImage;
      
      private var _nodeCon:Component;
      
      private var _fightBtn:IconButton;
      
      private var _formationBtn:IconButton;
      
      private var _childBox:VBox;
      
      private var _helpBtn:BaseButton;
      
      private var nodeList:Vector.<SpiritExpeditionNodeItem>;
      
      private var childList:Vector.<SpiritExpeditionNSHeadItem>;
      
      public var mapId:int;
      
      private var chapterInfo:SpiritExpeditionChapterInfo;
      
      private var nodeTempList:Array;
      
      private var nodePosAry:Array = [[140,20],[225,130],[295,20],[380,130],[465,20],[550,130],[620,20],[700,130],[775,20],[865,130]];
      
      public function SpiritExpeditionChapterFrame()
      {
         super();
         initView();
         initChildView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionChapterFrame.line");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.rightBg");
         _nodeCon = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.nodeCon");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.fightBtn");
         _formationBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.formationBtn");
         _childBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.childBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionChapterFrame.helpBtn");
         addToContent(_line);
         addToContent(_rightBg);
         addToContent(_nodeCon);
         addToContent(_fightBtn);
         addToContent(_formationBtn);
         addToContent(_helpBtn);
         addToContent(_childBox);
      }
      
      private function initNodeView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpiritExpeditionNodeItem = null;
         nodeTempList = TempleteManager.instance.spiritExpeditionTempCate.getChapterListByAreaId(mapId);
         nodeList = new Vector.<SpiritExpeditionNodeItem>();
         _loc2_ = 0;
         while(_loc2_ < nodeTempList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionChapterFrame.nodeItem");
            _loc1_.tempInfo = nodeTempList[_loc2_];
            _loc1_.x = _loc2_ >= nodePosAry.length ? 0 : nodePosAry[_loc2_][0];
            _loc1_.y = _loc2_ >= nodePosAry.length ? 0 : nodePosAry[_loc2_][1];
            _nodeCon.addChild(_loc1_);
            nodeList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initChildView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpiritExpeditionNSHeadItem = null;
         childList = new Vector.<SpiritExpeditionNSHeadItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SpiritExpeditionNSHeadItem(2);
            _loc1_.data = _loc2_ < model.enterWarList.length ? model.enterWarList[_loc2_] : null;
            _loc1_.tempInfo = _loc1_.data && _loc1_.data.childData ? _loc1_.data.childData.childTempInfo : null;
            _childBox.addChild(_loc1_);
            childList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _fightBtn.addEventListener("click",__fightClickHandler);
         _formationBtn.addEventListener("click",__formationClickHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("EXPEDITION_INFO_UPDATE",this,__updateExpeditionHandler);
         MsgMan.addObserver("FORMATION_INFO_UPDATE",this,__updateExpeditionChildHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_fightBtn)
         {
            _fightBtn.removeEventListener("click",__fightClickHandler);
         }
         if(_formationBtn)
         {
            _formationBtn.removeEventListener("click",__formationClickHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         MsgMan.removeObserver("EXPEDITION_INFO_UPDATE",this,__updateExpeditionHandler);
         MsgMan.removeObserver("FORMATION_INFO_UPDATE",this,__updateExpeditionChildHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("spiritExpedition.SpiritExpeditionChapterFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __updateExpeditionHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateExpeditionChildHandler(param1:String, param2:Object) : void
      {
         refreshChildView();
      }
      
      private function __fightClickHandler(param1:MouseEvent) : void
      {
         if(model.enterWarList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SpiritExpeditionChapterFrame.fight.needChildAlert"));
            return;
         }
         if(!hasEnergy)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SpiritExpeditionChapterFrame.fight.noEnergyAlert"));
            return;
         }
         model.tempMapId = mapId;
         SpiritExpeditionManager.instance.sendExpeditionFight(mapId,chapterInfo.passNodeId + 1);
      }
      
      private function __formationClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("spiritexpedition",3,2);
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:SpiritExpeditionNodeItem = null;
         var _loc1_:SpiritExpeditionNSHeadItem = null;
         chapterInfo = model.getChapterInfoById(mapId);
         if(!chapterInfo)
         {
            return;
         }
         _fightBtn.enable = chapterInfo.passNodeId < nodeTempList[nodeTempList.length - 1].NodeId;
         _loc3_ = 0;
         while(_loc3_ < nodeList.length)
         {
            _loc2_ = nodeList[_loc3_];
            _loc2_.refreshView();
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = childList[_loc3_];
            _loc1_.data = _loc3_ < model.enterWarList.length ? model.enterWarList[_loc3_] : null;
            _loc3_++;
         }
      }
      
      private function refreshChildView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpiritExpeditionNSHeadItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = childList[_loc2_];
            _loc1_.data = _loc2_ < model.enterWarList.length ? model.enterWarList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            mapId = param1.frameData as int;
            initNodeView();
         }
         refreshView();
      }
      
      public function get hasEnergy() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < model.enterWarList.length)
         {
            _loc1_ += model.enterWarList[_loc2_].energy;
            _loc2_++;
         }
         return _loc1_ > 0;
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_nodeCon);
         _nodeCon = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_formationBtn);
         _formationBtn = null;
         ObjectUtils.disposeObject(_childBox);
         _childBox = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         LogicUtils.disposeDisplayCollection(nodeList);
         nodeList = null;
         LogicUtils.disposeDisplayCollection(childList);
         childList = null;
         super.dispose();
      }
   }
}

