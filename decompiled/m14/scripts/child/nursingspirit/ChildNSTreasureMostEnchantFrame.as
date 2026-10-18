package child.nursingspirit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSTreasureMostEnchantFrame extends Frame
   {
      
      private var _bg:Image;
      
      private var _costImage:Image;
      
      private var _costCountTxt:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _resiContiner:Component;
      
      private var _currentResi:ScaleFrameImage;
      
      private var _radiusMc:MovieClip;
      
      private var _lightMc:MovieClip;
      
      private var _directionMc:MovieClip;
      
      private var _shawLightMc:MovieClip;
      
      private var _refreshGoodsTotalCount:int;
      
      private var _refreshNeedCount:int;
      
      private var _index:int;
      
      private var _currentResiType:int;
      
      private var _itemList:Array;
      
      private var _resiPosArr:Array = [[122,28],[203,75],[202,164],[122,209],[42,164],[42,75]];
      
      private var _lightMcPosArr:Array = [[122,30],[203,75],[202,164],[122,209],[42,164],[42,75]];
      
      private var _directionMcArr:Array = [[195,125],[198,170],[152,194],[117,179],[117,129],[152,105]];
      
      private var _rotationArr:Array = [-120,-60,0,60,120,180];
      
      private var _quardList:Array;
      
      private var _oldEnchantIndex:int;
      
      private var _type:int;
      
      private var _stopFrame:int;
      
      public function ChildNSTreasureMostEnchantFrame()
      {
         super();
         _refreshGoodsTotalCount = GoodsManager.instance.getGoodsNumByTempId(208203);
         _quardList = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
         initView();
         initEvent();
         initResiContain();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantFrame.bg");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantFrame.refreshBtn");
         _costCountTxt = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantFrame.costCountTxt");
         _costImage = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantFrame.costImage");
         _resiContiner = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantFrame.expContiner");
         _currentResi = ComponentFactory.Instance.creatComponentByStylename("childNSTreasureMostEnchantItem.resiIcon");
         _radiusMc = ComponentFactory.Instance.creatCustomObject("childNSTreasureMostEnchantItem.radiusMc");
         _lightMc = ComponentFactory.Instance.creatCustomObject("childNSTreasureMostEnchantItem.lightMc");
         _directionMc = ComponentFactory.Instance.creatCustomObject("childNSTreasureMostEnchantItem.directionMc");
         _shawLightMc = ComponentFactory.Instance.creatCustomObject("childNSTreasureMostEnchantItem.shawLightMc");
         addToContent(_bg);
         addToContent(_refreshBtn);
         addToContent(_costCountTxt);
         addToContent(_costImage);
         addToContent(_resiContiner);
         addToContent(_currentResi);
         _currentResi.x = 129;
         _currentResi.y = 126;
         addToContent(_radiusMc);
         addToContent(_lightMc);
         addToContent(_directionMc);
         addToContent(_shawLightMc);
         _radiusMc.stop();
         _lightMc.play();
         _directionMc.stop();
         _shawLightMc.stop();
         _directionMc.visible = _radiusMc.visible = _lightMc.visible = _shawLightMc.visible = false;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208203);
         if(_loc1_)
         {
            _costImage.tipData = _loc1_.TemplateName + ":" + _loc1_.Description;
         }
      }
      
      private function unInitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_costCountTxt)
         {
            ObjectUtils.disposeObject(_costCountTxt);
         }
         _costCountTxt = null;
         if(_costImage)
         {
            ObjectUtils.disposeObject(_costImage);
         }
         _costImage = null;
         if(_resiContiner)
         {
            ObjectUtils.disposeObject(_resiContiner);
         }
         _resiContiner = null;
         if(_currentResi)
         {
            ObjectUtils.disposeObject(_currentResi);
         }
         _currentResi = null;
         if(_radiusMc)
         {
            ObjectUtils.disposeObject(_radiusMc);
         }
         _radiusMc = null;
         if(_lightMc)
         {
            ObjectUtils.disposeObject(_lightMc);
         }
         _lightMc = null;
         if(_directionMc)
         {
            ObjectUtils.disposeObject(_directionMc);
         }
         _directionMc = null;
         if(_shawLightMc)
         {
            ObjectUtils.disposeObject(_shawLightMc);
         }
         _shawLightMc = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _refreshBtn.addEventListener("click",__refreshBtnHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
      }
      
      private function __nsOpBackHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(nsModel.enchantRefreshSuccess)
         {
            _type = param2 as int;
            _loc3_ = _oldEnchantIndex * 2 + 1;
            if(nsModel.enchantIndex > _oldEnchantIndex)
            {
               _stopFrame = 12 + _loc3_ + (nsModel.enchantIndex - _oldEnchantIndex) * 2;
            }
            else
            {
               _stopFrame = 12 + _loc3_ + (nsModel.enchantIndex + 6 - _oldEnchantIndex) * 2;
            }
            _radiusMc.visible = true;
            _radiusMc.gotoAndPlay(_loc3_);
            _radiusMc.addFrameScript(_stopFrame,playLightMc);
         }
      }
      
      private function playLightMc() : void
      {
         _radiusMc.gotoAndStop(1);
         _radiusMc.addFrameScript(_stopFrame,null);
         _radiusMc.visible = false;
         _lightMc.visible = true;
         _lightMc.x = _lightMcPosArr[nsModel.enchantIndex][0];
         _lightMc.y = _lightMcPosArr[nsModel.enchantIndex][1];
         _lightMc.gotoAndPlay(1);
         _lightMc.addFrameScript(_lightMc.totalFrames - 1,playDirectionMc);
      }
      
      private function playDirectionMc() : void
      {
         _lightMc.addFrameScript(_lightMc.totalFrames - 1,null);
         _lightMc.visible = false;
         _lightMc.stop();
         _directionMc.visible = true;
         _directionMc.x = _directionMcArr[nsModel.enchantIndex][0];
         _directionMc.y = _directionMcArr[nsModel.enchantIndex][1];
         _directionMc.rotation = _rotationArr[nsModel.enchantIndex];
         _directionMc.gotoAndPlay(1);
         _directionMc.addFrameScript(5,playDirection);
         _directionMc.addFrameScript(_directionMc.totalFrames - 1,playDirectionComplete);
      }
      
      private function playDirection() : void
      {
         _directionMc.addFrameScript(5,null);
         _shawLightMc.visible = true;
         _shawLightMc.gotoAndPlay(1);
         _shawLightMc.addFrameScript(5,shawLightMcHander);
         _shawLightMc.addFrameScript(_shawLightMc.totalFrames - 1,shawLightMcComplete);
      }
      
      private function shawLightMcComplete() : void
      {
         _shawLightMc.addFrameScript(_shawLightMc.totalFrames - 1,null);
         _shawLightMc.visible = false;
         _shawLightMc.stop();
      }
      
      private function shawLightMcHander() : void
      {
         if(_type == 43)
         {
            setSelectedByResiIndex(nsModel.enchantIndex);
         }
         _currentResi.setFrame(nsModel.enchantIndex + 1);
         _currentResi.tipData = _quardList[nsModel.enchantIndex];
         _refreshGoodsTotalCount = GoodsManager.instance.getGoodsNumByTempId(208203);
         _costCountTxt.text = _refreshGoodsTotalCount + "/" + _refreshNeedCount;
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.nursingspirit.childNSTreasureMostEquipItem.refresh.success"));
         _refreshBtn.enable = true;
      }
      
      private function playDirectionComplete() : void
      {
         _directionMc.addFrameScript(_directionMc.totalFrames - 1,null);
         _directionMc.visible = false;
         _directionMc.stop();
      }
      
      private function initResiContain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildNSTreasureMostEnchantItem = null;
         _itemList = [];
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = new ChildNSTreasureMostEnchantItem();
            _loc2_.x = _resiPosArr[_loc1_][0];
            _loc2_.y = _resiPosArr[_loc1_][1];
            _loc2_.selected = false;
            _loc2_.index = _loc1_;
            _resiContiner.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_refreshGoodsTotalCount < _refreshNeedCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips01"));
            return;
         }
         resertSelectedStatus();
         _oldEnchantIndex = nsModel.enchantIndex;
         ChildSender.nsTreasureMostEnchant(nsModel.selectedNsChild.childId,_index);
         _refreshBtn.enable = false;
      }
      
      private function resertSelectedStatus() : void
      {
         var _loc2_:ChildNSTreasureMostEnchantItem = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc1_] as ChildNSTreasureMostEnchantItem;
            if(_loc2_)
            {
               _loc2_.selected = false;
            }
            _loc1_++;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function setSelectedByResiIndex(param1:int) : void
      {
         var _loc3_:ChildNSTreasureMostEnchantItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc3_ = _itemList[_loc2_] as ChildNSTreasureMostEnchantItem;
            if(_loc3_ && _loc3_.index == param1)
            {
               _loc3_.selected = true;
               break;
            }
            _loc2_++;
         }
      }
      
      private function initData(param1:ModuleFrameInfo) : void
      {
         if(param1 && param1.frameData)
         {
            _index = int(param1.frameData.frameIndex);
            _currentResiType = int(param1.frameData.frameResiType);
            _currentResi.setFrame(_currentResiType + 1);
            _oldEnchantIndex = _currentResiType;
            _currentResi.tipData = _quardList[_currentResiType];
            setSelectedByResiIndex(_currentResiType);
         }
         var _loc2_:Array = ConfigInfoManager.instance.getNsTreasureMostRefreshCount();
         if(_loc2_)
         {
            _refreshNeedCount = _loc2_[_index];
         }
         _costCountTxt.text = _refreshGoodsTotalCount + "/" + _refreshNeedCount;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         initData(param1);
         this.titleText = LanguageMgr.GetTranslation("store.view.LifeSkillFrame.item.alertSkillName4");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

