package avenger
{
   import avenger.item.AvengerDevilArmorCarveItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerDevilArmorCarveFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _holeImage:MutipleImage;
      
      private var _holeGradeText:FilterFrameText;
      
      private var _propBg:Bitmap;
      
      private var _curItem:AvengerDevilArmorCarveItem;
      
      private var _nextItem:AvengerDevilArmorCarveItem;
      
      private var _expBar:ProgressCommon;
      
      private var _costImage:MutipleImage;
      
      private var _costText:FilterFrameText;
      
      private var _itemImage:Image;
      
      private var _hasMaterialText:FilterFrameText;
      
      private var _carveBtn:IconButton;
      
      private var _alertText:FilterFrameText;
      
      private var _maxBg:Bitmap;
      
      private var _maxGradeText:FilterFrameText;
      
      private var data:AvengerDevilArmorHoleInfo;
      
      private var hasMaterialCount:int;
      
      public function AvengerDevilArmorCarveFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.bg");
         _holeImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.holeImage");
         _holeGradeText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.holeGradeText");
         _propBg = ComponentFactory.Instance.creatBitmap("asset.AvengerDevilArmorCarveFrame.propBg");
         _curItem = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorCarveFrame.curItem",[1]);
         _nextItem = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorCarveFrame.nextItem",[2]);
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.expBar");
         _costImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.costImage");
         _costText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.costText");
         _hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.hasMaterialText");
         _carveBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.carveBtn");
         _maxBg = ComponentFactory.Instance.creatBitmap("asset.AvengerDevilArmorCarveFrame.maxBg");
         _maxGradeText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.maxGradeText");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.alertText");
         _itemImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorCarveFrame.itemImage");
         addToContent(_bg);
         addToContent(_holeImage);
         addToContent(_holeGradeText);
         addToContent(_propBg);
         addToContent(_curItem);
         addToContent(_nextItem);
         addToContent(_expBar);
         addToContent(_costImage);
         addToContent(_itemImage);
         addToContent(_costText);
         addToContent(_hasMaterialText);
         addToContent(_carveBtn);
         addToContent(_maxBg);
         addToContent(_maxGradeText);
         addToContent(_alertText);
         _costText.text = "1";
         _alertText.text = LanguageMgr.GetTranslation("AvengerDevilArmorCarveFrame.alertText.text");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(6920001);
         if(_loc1_)
         {
            _itemImage.tipData = _loc1_.TemplateName + "\n" + _loc1_.Description;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _costText.addEventListener("change",__textChangHandler);
         _carveBtn.addEventListener("click",__carveClickHandler);
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagCountHandler);
         MsgMan.addObserver("DEVIL_ARMOR_INFO_UPDATE",this,__devilArmorChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_costText)
         {
            _costText.removeEventListener("change",__textChangHandler);
         }
         if(_carveBtn)
         {
            _carveBtn.removeEventListener("click",__carveClickHandler);
         }
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagCountHandler);
         MsgMan.removeObserver("DEVIL_ARMOR_INFO_UPDATE",this,__devilArmorChangeHandler);
      }
      
      private function __devilArmorChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateBagCountHandler(param1:String, param2:Object) : void
      {
         hasMaterialCount = model.armorBagDic[6920001] ? model.armorBagDic[6920001].count : 0;
         _hasMaterialText.text = LanguageMgr.GetTranslation("goddess.advance.needItemNum",hasMaterialCount);
      }
      
      private function __carveClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(_costText.text);
         if(hasMaterialCount < _loc2_ || _loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         AvengerManager.instance.sendDevilArmorCarveRequest(data.pos,_loc2_);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_costText.text);
         if(_loc2_ <= 0)
         {
            _costText.text = "1";
         }
         if(_loc2_ >= hasMaterialCount)
         {
            _costText.text = hasMaterialCount + "";
         }
      }
      
      private function refreshView() : void
      {
         if(!data)
         {
            return;
         }
         data = model.devilArmorInfo.holeDic[data.pos];
         _holeGradeText.text = LanguageMgr.GetTranslation("public.level2",data.grade);
         hasMaterialCount = model.armorBagDic[6920001] ? model.armorBagDic[6920001].count : 0;
         _hasMaterialText.text = LanguageMgr.GetTranslation("goddess.advance.needItemNum",hasMaterialCount);
         if(data.nextTempInfo)
         {
            _carveBtn.visible = true;
            _maxBg.visible = false;
            _nextItem.visible = true;
            _curItem.x = 25;
            _maxGradeText.text = "";
            _expBar.value = data.exp / data.tempInfo.NeedItemNum;
            _expBar.text = data.exp + "/" + data.tempInfo.NeedItemNum;
            _nextItem.setPropData(data);
         }
         else
         {
            _carveBtn.visible = false;
            _maxBg.visible = true;
            _nextItem.visible = false;
            _curItem.x = 118;
            _maxGradeText.text = LanguageMgr.GetTranslation("buildings.water.view.PlayerTreeExpView.msg01");
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
         }
         _curItem.setPropData(data);
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
         this.titleText = LanguageMgr.GetTranslation("AvengerDevilArmorCarveFrame.title.text");
         if(param1 && param1.frameData)
         {
            data = param1.frameData as AvengerDevilArmorHoleInfo;
         }
         refreshView();
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_holeImage);
         _holeImage = null;
         ObjectUtils.disposeObject(_holeGradeText);
         _holeGradeText = null;
         ObjectUtils.disposeObject(_propBg);
         _propBg = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_costImage);
         _costImage = null;
         ObjectUtils.disposeObject(_costText);
         _costText = null;
         ObjectUtils.disposeObject(_hasMaterialText);
         _hasMaterialText = null;
         ObjectUtils.disposeObject(_carveBtn);
         _carveBtn = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_maxBg);
         _maxBg = null;
         ObjectUtils.disposeObject(_maxGradeText);
         _maxGradeText = null;
         ObjectUtils.disposeObject(_curItem);
         _curItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         super.dispose();
      }
   }
}

