package secretary.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SecretaryManager;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.secretary.SecretaryData;
   import mvc.module.secretary.SecretaryItemData;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class SecretaryAltarItem extends Sprite
   {
      
      public static const LEVEL_ARR:Array = [1,4,7];
      
      private var _goodsTxt:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _consumeContributionTxt:FilterFrameText;
      
      private var _consumeAchievementTxt:FilterFrameText;
      
      public var _bg:MovieClip;
      
      private var _iconArr:Array = [];
      
      private var _leftCountTxt:FilterFrameText;
      
      public var _moneyBg:Bitmap;
      
      public var _costBg:Bitmap;
      
      public var _orangebg:Bitmap;
      
      private var _select:SelectedButton;
      
      private var _data:SecretaryItemData;
      
      public function SecretaryAltarItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AltarIcon = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creat("asset.secrearytary.bg2");
         _orangebg = ComponentFactory.Instance.creat("asset.secrearytary.orangebg");
         _bg.width = 503;
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryItem.titleText");
         _title.y = 8;
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryAltarItem.goodsTxt");
         _consumeContributionTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryAltarItem.consumeContributionTxt");
         _consumeAchievementTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryAltarItem.consumeAchievementTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryAltarItem.leftCountTxt");
         _costBg = ComponentFactory.Instance.creatBitmap("asset.core.NormalPriceBg");
         _costBg.width = 255;
         _costBg.x = 48;
         _costBg.y = 163;
         _select = ComponentFactory.Instance.creatComponentByStylename("secretaryItem.RefreshShopSelectButton");
         _moneyBg = ComponentFactory.Instance.creatBitmap("asset.core.NormalPriceBg");
         _moneyBg.width = 145;
         _moneyBg.height = 60;
         _moneyBg.x = 48;
         _moneyBg.y = 250;
         addChild(_bg);
         addChild(_orangebg);
         addChild(_select);
         addChild(_costBg);
         addChild(_moneyBg);
         addChild(_consumeContributionTxt);
         addChild(_consumeAchievementTxt);
         addChild(_goodsTxt);
         addChild(_title);
         addChild(_leftCountTxt);
         _select.selected = true;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new AltarIcon(_loc3_ + 1);
            _loc2_ = int(LEVEL_ARR[_loc3_]);
            if(modelConsortia.consortiaInfo.altarLevel < _loc2_)
            {
               _loc1_.mouseEnabled = false;
               _loc1_.mouseChildren = false;
            }
            _loc1_.select = _loc3_ + 1 == modelConsortia.altarWorshipIndex;
            _loc1_.x = _loc3_ * 150;
            _loc1_.y = 50;
            _iconArr.push(_loc1_);
            addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function get modelConsortia() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      public function set data(param1:SecretaryItemData) : void
      {
         _data = param1;
         _title.text = _data.title;
         _select.selected = _data.state;
         var _loc2_:int = int(model1.alTarBlessLeftTime);
         _loc2_ = totalTime - _loc2_ < 0 ? 0 : totalTime - _loc2_;
         _goodsTxt.text = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.goodsTxt.text" + modelConsortia.altarWorshipIndex);
         _consumeContributionTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeContributionTxt.text",consume);
         _consumeAchievementTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeAchievementTxt.text",altarReputationCost);
         _leftCountTxt.htmlText = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips6",_loc2_,totalTime);
      }
      
      private function get totalTime() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model1.consortiaInfo.altarLevel).Property2;
      }
      
      private function get consume() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model1.consortiaInfo.altarLevel).Property1;
      }
      
      private function get altarReputationCost() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.getAltarReputationCost();
         return _loc1_[modelConsortia.altarWorshipIndex - 1];
      }
      
      private function get model1() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("secretary_item_AltarIcon",this,__onSelectChangeHandler);
         _select.addEventListener("click",__pointSelectedHandler);
      }
      
      private function __onSelectChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = int(model1.alTarBlessLeftTime);
         _loc3_ = totalTime - _loc3_ < 0 ? 0 : totalTime - _loc3_;
         _goodsTxt.text = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.goodsTxt.text" + modelConsortia.altarWorshipIndex);
         _consumeContributionTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeContributionTxt.text",consume);
         _consumeAchievementTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeAchievementTxt.text",altarReputationCost);
         _leftCountTxt.htmlText = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips6",_loc3_,totalTime);
      }
      
      private function __pointSelectedHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < model.allItemDatas.length)
         {
            if(model.allItemDatas[_loc3_].type == _data.type)
            {
               _loc2_ = Boolean(model.allItemDatas[_loc3_].state);
               model.allItemDatas[_loc3_].state = !_loc2_;
               _select.selected = model.allItemDatas[_loc3_].state;
               return;
            }
            _loc3_++;
         }
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("secretary_item_AltarIcon",this,__onSelectChangeHandler);
         _select.removeEventListener("click",__pointSelectedHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

