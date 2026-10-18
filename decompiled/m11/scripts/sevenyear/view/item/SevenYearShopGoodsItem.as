package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.module.TreasureBoxMsg;
   import events.SevenYearEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.SevenYearManager;
   import mvc.module.pet.PetData;
   import mvc.module.sevenyear.SevenYearModel;
   import mvc.module.shop.ShopGoodsInfo;
   import sevenyear.SevenYearTreasureBoxFrame;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   
   public class SevenYearShopGoodsItem extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _valueTxt:FilterFrameText;
      
      protected var _goods:BaseItemView;
      
      protected var _buyBtn:IconButton;
      
      protected var _tips:FilterFrameText;
      
      protected var _lineImg:ScaleFrameImage;
      
      protected var _data:ShopGoodsInfo;
      
      protected var _filter:IFilterFormat;
      
      protected var _hasOwnTxt:FilterFrameText;
      
      private var _flag:ScaleFrameImage;
      
      private var _preViewFlag:Boolean = false;
      
      public function SevenYearShopGoodsItem(param1:Boolean = false)
      {
         _preViewFlag = param1;
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _hasOwnTxt = ComponentFactory.Instance.creatComponentByStylename("shop.hasOwnTxt");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemContributeTxtImg");
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_goods);
         _tips.x = 24;
         _tips.y = 87;
      }
      
      protected function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
         model.addEventListener("UPDATE_TREASUREBOX_INFO",__updateTreasureBoxInfo);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
         model.removeEventListener("UPDATE_TREASUREBOX_INFO",__updateTreasureBoxInfo);
      }
      
      private function __updateTreasureBoxInfo(param1:SevenYearEvent) : void
      {
         updateOwn();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _buyBtn)
         {
            __onBuyBtnHandler(param1);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         __onBuyBtnHandler(null);
      }
      
      protected function __onBuyBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:SevenYearTreasureBoxFrame = null;
         if(!_data)
         {
            return;
         }
         if(_data.ShopType == 36)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
            if(_loc2_)
            {
               if(_loc2_.SonType == 667 || _loc2_.SonType == 666)
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("sevenyear.SevenYearTreasureBoxFrame");
                  _loc3_.data = _data;
                  _loc3_.show();
                  return;
               }
            }
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc1_.data(_data);
         _loc1_.show();
      }
      
      private function conformBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         _data = param1;
         if(param1)
         {
            addEvent();
            setHasOwn(_data);
            _nameTxt.text = getName();
            _nameTxt.visible = true;
            _valueTxt.text = _data.price + "";
            _lineImg.setFrame(_data.PayType);
            updateOwn();
         }
         else
         {
            clean();
            removeEvent();
            if(_hasOwnTxt)
            {
               _hasOwnTxt.text = "";
            }
         }
         if(_data.template.SonType == 667)
         {
            _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemLookBtn2");
            _valueTxt.text = "";
            _lineImg.visible = false;
         }
         else
         {
            _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
            _lineImg.visible = true;
         }
         addChild(_buyBtn);
      }
      
      private function updateOwn() : void
      {
         var _loc1_:TreasureBoxMsg = null;
         var _loc2_:int = 0;
         if(model.boxList[_data.ItemId])
         {
            _loc1_ = model.boxList[_data.ItemId];
            _loc2_ = int(_loc1_.count);
         }
         _tips.text = LanguageMgr.GetTranslation("SevenYearShopGoodsItem.str",_loc2_);
      }
      
      public function setHasOwn(param1:ShopGoodsInfo) : void
      {
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:PetData = null;
         var _loc5_:Boolean = false;
         var _loc4_:int = int(param1.ItemId);
         var _loc7_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_);
         var _loc2_:int = int(_loc7_.SonType);
         var _loc6_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(!_hasOwnTxt)
         {
            return;
         }
         _hasOwnTxt.text = "";
         switch(_loc2_)
         {
            case 211:
               if(_loc6_.composeList.indexOf(_loc7_.Property1) > 0)
               {
                  _hasOwnTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
                  addChild(_hasOwnTxt);
               }
               break;
            case 218:
               if(MountsManager.instance.avatarList.isLightTemplate(_loc7_.Property1))
               {
                  _hasOwnTxt.text = LanguageMgr.GetTranslation("Task.view.GoodsItem.hasOwnTxt.text");
                  addChild(_hasOwnTxt);
               }
               break;
            case 303:
               _loc3_ = _loc6_.petList;
               _loc8_ = 0;
               while(_loc8_ < _loc3_.length)
               {
                  _loc9_ = _loc3_[_loc8_] as PetData;
                  _loc5_ = Boolean(_loc9_.checkSkillIsLearned(_loc7_.Property1));
                  if(_loc5_)
                  {
                     _hasOwnTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
                     addChild(_hasOwnTxt);
                     break;
                  }
                  _loc8_++;
               }
         }
      }
      
      private function setFlag(param1:int = 0) : void
      {
         if(param1 > 0)
         {
            _flag = ComponentFactory.Instance.creatComponentByStylename("shop.ItemLabel");
            addChild(_flag);
            _flag.mouseChildren = _flag.mouseEnabled = false;
            _flag.setFrame(param1 + 1);
         }
      }
      
      public function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getName() : String
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.ItemId;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.ItemId);
         _loc2_.validDate = _data.ValidDate;
         _goods.data = _loc2_;
         return _loc1_.TemplateName;
      }
      
      protected function clean() : void
      {
         _nameTxt.visible = false;
         _valueTxt.visible = false;
         _buyBtn.visible = false;
         _lineImg.visible = false;
         _goods.data = null;
         _tips.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_hasOwnTxt);
         _hasOwnTxt = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         _filter = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

