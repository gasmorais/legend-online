package consortia.view.myConsortia.skill
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTempleteInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaStudySkillFrame extends Frame implements IManualSize
   {
      
      private var _btn1:SelectedIconButton;
      
      private var _btn2:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _data:ConsortiaModel;
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _ownSkillBg:ScaleFrameImage;
      
      private var _ownSkillTxtImg:Bitmap;
      
      private var _studySkilllist:SimpleTileList;
      
      private var _ownSkillVBox:VBox;
      
      private var _studySkillPanel:ScrollPanel;
      
      private var _studySkillItemList:Array;
      
      private var _ownSkillPanel:ScrollPanel;
      
      private var _ownSkillItemList:Array;
      
      private var _downBg:ScaleBitmapImage;
      
      private var _promptTxt:Bitmap;
      
      private var _contributebgTxt:Bitmap;
      
      private var _neededItem:BaseItemView;
      
      private var _contributetxt:FilterFrameText;
      
      private var _isShow:Boolean = false;
      
      private var _openFromConsortiaFrame:int;
      
      public function ConsortiaStudySkillFrame()
      {
         super();
         initView();
         addEvent();
         initData();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,667,534);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.consortiaController.getShowSkills();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaStudySkillFrame.titleText");
         _downBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaStudySkillFrame.BackGround");
         _promptTxt = ComponentFactory.Instance.creatBitmap("asset.consortia.Skill.promptTxt");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaStudySkillFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaStudySkillFrame.btn2");
         _ownSkillItemList = [];
         _studySkillItemList = [];
         _data = FrameControllerManager.instance.consortiaController.model;
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("consortia.SkillFrameLeftDescribeBackground");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("consortia.SkillFrameRightDescribeBackground");
         _ownSkillBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ownSkillBg");
         _ownSkillTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.ownSkillTxtImg");
         _studySkilllist = ComponentFactory.Instance.creatCustomObject("consortia.SkillSimpleTileList",[2]);
         _studySkillPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.StudySkillScrollPanel");
         _ownSkillVBox = ComponentFactory.Instance.creatComponentByStylename("consortia.OwnSkillvbox");
         _ownSkillPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.OwnSkillScrollPanel");
         _contributebgTxt = ComponentFactory.Instance.creatBitmap("asset.consortia.SkillDisplayShowTxt");
         _contributetxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeTextStyle");
         _neededItem = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaStudySkillFrame.neededItem");
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_ownSkillBg);
         addToContent(_ownSkillTxtImg);
         addToContent(_downBg);
         addToContent(_promptTxt);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_studySkillPanel);
         addToContent(_ownSkillPanel);
         addToContent(_contributebgTxt);
         addToContent(_neededItem);
         addToContent(_contributetxt);
         _contributetxt.text = playerInfo.consortiaOffer + "";
         _studySkillPanel.setView(_studySkilllist);
         _ownSkillPanel.setView(_ownSkillVBox);
         setOwnSkill();
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 208040;
         _neededItem.data = _loc1_;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_btn1);
         _btnGroup.addSelectItem(_btn2);
         _btnGroup.selectIndex = 0;
         __selectedHandler(null);
      }
      
      private function uninit() : void
      {
         _data = null;
         for each(var _loc1_:ConsortiaOwnSkillItem in _ownSkillItemList)
         {
            _loc1_.dispose();
         }
         _ownSkillItemList = null;
         for each(var _loc2_:ConsortiaSkillItem in _studySkillItemList)
         {
            _loc2_.dispose();
         }
         _studySkillItemList = null;
         if(_btn1)
         {
            _btn1.dispose();
         }
         _btn1 = null;
         if(_btn2)
         {
            _btn2.dispose();
         }
         _btn2 = null;
         if(_btnGroup)
         {
            _btnGroup.dispose();
         }
         _btnGroup = null;
         if(_leftBg)
         {
            _leftBg.dispose();
         }
         _leftBg = null;
         if(_rightBg)
         {
            _rightBg.dispose();
         }
         _rightBg = null;
         if(_ownSkillBg)
         {
            _ownSkillBg.dispose();
         }
         _ownSkillBg = null;
         if(_studySkilllist)
         {
            ObjectUtils.disposeObject(_studySkilllist);
         }
         _studySkilllist = null;
         if(_ownSkillVBox)
         {
            ObjectUtils.disposeObject(_ownSkillVBox);
         }
         _ownSkillVBox = null;
         if(_studySkillPanel)
         {
            _studySkillPanel.dispose();
         }
         _studySkillPanel = null;
         if(_ownSkillPanel)
         {
            ObjectUtils.disposeObject(_ownSkillPanel);
         }
         _ownSkillPanel = null;
         if(_downBg)
         {
            _downBg.dispose();
         }
         _downBg = null;
         if(_neededItem)
         {
            _neededItem.dispose();
         }
         _neededItem = null;
         if(_contributetxt)
         {
            _contributetxt.dispose();
         }
         _contributetxt = null;
         ObjectUtils.disposeObject(_ownSkillTxtImg);
         _ownSkillTxtImg = null;
         ObjectUtils.disposeObject(_promptTxt);
         _promptTxt = null;
         ObjectUtils.disposeObject(_contributebgTxt);
         _contributebgTxt = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__selectedHandler);
         }
         if(_data)
         {
            _data.addEventListener("UPDA_CONSORTIA_SKILL_LIST",__onSkillListUpdata);
         }
         playerInfo.addEventListener("CONSORTIA_STUDY",__addOwnSkill);
         playerInfo.addEventListener("CONSORTIA_STUDY_UPGRADE",__updataOwnSkill);
         playerInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__goodsChangeHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__goodsChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__selectedHandler);
         }
         if(_data)
         {
            _data.removeEventListener("UPDA_CONSORTIA_SKILL_LIST",__onSkillListUpdata);
         }
         playerInfo.removeEventListener("CONSORTIA_STUDY",__addOwnSkill);
         playerInfo.removeEventListener("CONSORTIA_STUDY_UPGRADE",__updataOwnSkill);
         playerInfo.removeEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__goodsChangeHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__goodsChangeHandler);
      }
      
      private function __goodsChangeHandler(param1:BagEvent) : void
      {
         if(_btnGroup && _btnGroup.selectIndex == 1 && _contributetxt)
         {
            _contributetxt.text = GoodsManager.instance.getBagCountByTempId(1,ConsortiaModel.UPSKILL_GOODS_TEMPID) + "";
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         if(_btnGroup)
         {
            if(_btnGroup.selectIndex == 0)
            {
               _ownSkillBg.setFrame(1);
               _contributetxt.x = 70;
               _contributetxt.text = playerInfo.consortiaOffer + "";
               _neededItem.visible = false;
               _contributebgTxt.visible = true;
            }
            else if(_btnGroup.selectIndex == 1)
            {
               _ownSkillBg.setFrame(2);
               _contributetxt.x = 60;
               _contributetxt.text = GoodsManager.instance.getBagCountByTempId(1,ConsortiaModel.UPSKILL_GOODS_TEMPID) + "";
               _contributebgTxt.visible = false;
               _neededItem.visible = true;
            }
            __onSkillListUpdata(null);
         }
      }
      
      private function __onContributeUpdata(param1:PlayerEvent) : void
      {
         if(_btnGroup)
         {
            if(_btnGroup.selectIndex == 0)
            {
               _contributetxt.text = playerInfo.consortiaOffer + "";
            }
            else if(_btnGroup.selectIndex == 1)
            {
               _contributetxt.text = GoodsManager.instance.getBagCountByTempId(1,208040) + "";
            }
         }
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __onSkillListUpdata(param1:ConsortiaEvent) : void
      {
         setStudySkill();
         refreshPosition();
      }
      
      private function setStudySkill() : void
      {
         var _loc3_:ConsortiaTempleteInfo = null;
         var _loc5_:int = 0;
         var _loc2_:ConsortiaSkillItem = null;
         _studySkillPanel.beginChanges();
         _studySkillItemList.length = 0;
         _studySkilllist.removeAllChild();
         var _loc1_:Array = _data.baseSkillList.getList().sortOn("type",16);
         var _loc4_:int = int(_loc1_.length > 6 ? _loc1_.length : 6);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc1_[_loc5_] as ConsortiaTempleteInfo;
            if(_loc3_ && isFilterType(_loc3_.type))
            {
               _loc2_ = new ConsortiaSkillItem();
               _loc2_.data = _loc1_[_loc5_];
               _studySkillItemList.push(_loc2_);
               _studySkilllist.addChild(_loc2_);
            }
            _loc5_++;
         }
         _studySkillPanel.commitChanges();
         _studySkillPanel.invalidateViewport();
      }
      
      private function isFilterType(param1:int) : Boolean
      {
         var _loc2_:Boolean = _btnGroup && _btnGroup.selectIndex == 0;
         return _loc2_ && isCommonSkill(param1) || !_loc2_ && !isCommonSkill(param1);
      }
      
      private function isCommonSkill(param1:int = 0) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1 - 6)
         {
            case 0:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function refreshPosition() : void
      {
         if(!_studySkillPanel.vScrollbar.visible)
         {
            _studySkillPanel.x = 9;
            _studySkillPanel.y = 40;
         }
         else
         {
            _studySkillPanel.x = 2;
            _studySkillPanel.y = 35;
         }
      }
      
      private function updataStudySkill(param1:int) : void
      {
         for each(var _loc2_:ConsortiaSkillItem in _studySkillItemList)
         {
            if(_loc2_.data.type == param1)
            {
               _loc2_.refreshView();
               break;
            }
         }
      }
      
      private function __updataOwnSkill(param1:ConsortiaEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = int(param1.data);
         updataStudySkill(_loc4_);
         for each(var _loc2_:ConsortiaOwnSkillItem in _ownSkillItemList)
         {
            if(_loc2_.upgradeType == _loc4_)
            {
               _loc3_ = int(ConsortiaSkillHelper.getLevelByType(_loc4_,playerInfo));
               _loc2_.data = [_loc3_,_loc4_];
               break;
            }
         }
      }
      
      private function __addOwnSkill(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(param1.data);
         updataStudySkill(_loc3_);
         if(!checkExist(_loc3_))
         {
            _ownSkillPanel.beginChanges();
            _loc2_ = int(ConsortiaSkillHelper.getLevelByType(_loc3_,playerInfo));
            addOwnSkillItem([_loc2_,_loc3_]);
            _ownSkillPanel.invalidateViewport();
            _ownSkillPanel.commitChanges();
            if(_ownSkillPanel.vScrollbar.visible)
            {
               _ownSkillPanel.x = 445;
            }
            else
            {
               _ownSkillPanel.x = 455;
            }
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return _data.consortiaInfo;
      }
      
      private function setOwnSkill() : void
      {
         _ownSkillPanel.beginChanges();
         addSkillItem();
         _ownSkillPanel.commitChanges();
         _ownSkillPanel.invalidateViewport();
         if(_ownSkillPanel.vScrollbar.visible)
         {
            _ownSkillPanel.x = 445;
         }
         else
         {
            _ownSkillPanel.x = 455;
         }
      }
      
      private function addSkillItem() : void
      {
         if(playerInfo.consortiaPower)
         {
            addOwnSkillItem([playerInfo.consortiaPower,6]);
         }
         if(playerInfo.consortiaAgility)
         {
            addOwnSkillItem([playerInfo.consortiaAgility,8]);
         }
         if(playerInfo.consortiaIntellect)
         {
            addOwnSkillItem([playerInfo.consortiaIntellect,9]);
         }
         if(playerInfo.consortiaCaptain)
         {
            addOwnSkillItem([playerInfo.consortiaCaptain,10]);
         }
         if(playerInfo.consortiaPhysique)
         {
            addOwnSkillItem([playerInfo.consortiaPhysique,12]);
         }
         if(playerInfo.consortiaGold)
         {
            addOwnSkillItem([playerInfo.consortiaGold,11]);
         }
         if(playerInfo.newPowerLv)
         {
            addOwnSkillItem([playerInfo.newPowerLv,13]);
         }
         if(playerInfo.newAgilityLv)
         {
            addOwnSkillItem([playerInfo.newAgilityLv,14]);
         }
         if(playerInfo.newIntellectLv)
         {
            addOwnSkillItem([playerInfo.newIntellectLv,15]);
         }
         if(playerInfo.newPhysiqueLv)
         {
            addOwnSkillItem([playerInfo.newPhysiqueLv,16]);
         }
         if(playerInfo.famGpLv)
         {
            addOwnSkillItem([playerInfo.famGpLv,17]);
         }
         if(playerInfo.medalLv)
         {
            addOwnSkillItem([playerInfo.medalLv,18]);
         }
         if(playerInfo.honorLv)
         {
            addOwnSkillItem([playerInfo.honorLv,19]);
         }
         if(playerInfo.propertyLv)
         {
            addOwnSkillItem([playerInfo.propertyLv,21]);
         }
      }
      
      private function addOwnSkillItem(param1:Array) : void
      {
         var _loc2_:ConsortiaOwnSkillItem = new ConsortiaOwnSkillItem();
         _loc2_.data = param1;
         _ownSkillItemList.push(_loc2_);
         _ownSkillVBox.addChild(_loc2_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function checkExist(param1:int) : Boolean
      {
         for each(var _loc2_:ConsortiaOwnSkillItem in _ownSkillItemList)
         {
            if(_loc2_.upgradeType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _isShow = true;
               dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         _openFromConsortiaFrame = param1;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
         FrameControllerManager.instance.consortiaController.closeSkillFrame(_openFromConsortiaFrame,_isShow);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
      }
   }
}

