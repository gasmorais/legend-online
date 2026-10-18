package theseus.warFrame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.TheseussoulManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.warFrame.item.WarframeMetrailCell;
   import theseus.warFrame.item.WarframeQhCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleDictionary;
   
   public class WarframeEnhancementView extends Sprite
   {
      
      public var _inf1from:WarframeQhCell;
      
      public var _inf1Metrial:WarframeMetrailCell;
      
      public var _inf1Next:WarframeQhCell;
      
      public var _inf1NameTx:FilterFrameText;
      
      public var _info1QhBtn:IconButton;
      
      private var _arrow:MovieClip;
      
      private var _maxItem:TheseusWarMaxItem;
      
      public var _allNum:FilterFrameText;
      
      public var _mainPriceIcon:ScaleFrameImage;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      public function WarframeEnhancementView()
      {
         super();
         initView();
         initEvent();
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      }
      
      private function initView() : void
      {
         _inf1from = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.WarframeQhCell");
         _inf1Metrial = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.WarframeMetrailCell");
         _inf1Next = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.WarframeQhCell");
         _inf1NameTx = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.inf1NameTx");
         _info1QhBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.info1QhBtn");
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensify1Row");
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensifyMaxItem");
         _maxItem.redStr(LanguageMgr.GetTranslation("theseus.war.FrameMaxTip"));
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseus.war.insMaxTitle"));
         _maxItem.updateTitlePos(44,2);
         _maxItem.updateRightBitPos(235,0);
         _maxItem.updateleftBitPos(-20,0);
         addChild(_inf1from);
         addChild(_inf1Metrial);
         addChild(_inf1Next);
         addChild(_inf1NameTx);
         addChild(_info1QhBtn);
         addChild(_arrow);
         addChild(_maxItem);
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 1;
         _inf1from.funType = 1;
         _inf1from.isNeedMediator = true;
         _info1QhBtn.enable = false;
         _maxItem.visible = false;
         _inf1Next.y = 190;
         _inf1Next.defaultStr = LanguageMgr.GetTranslation("theseus.war.intensifyYL");
         _allNum = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.allNum");
         _mainPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.mainPriceIcon");
         addChild(_allNum);
         addChild(_mainPriceIcon);
         _mainPriceIcon.x = 55;
         _mainPriceIcon.y = 292;
         _mainPriceIcon.scaleX = _mainPriceIcon.scaleY = 0.8;
         _allNum.text = "0";
         _allNum.x = 20;
         _allNum.y = 283;
         _mainPriceIcon.setFrame(1);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("EventWarFrameInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("EventWarFrameInsPutOut",outUpdateHandler);
         _info1QhBtn.addEventListener("click",clickHandler);
         TheseussoulManager.Instance.addEventListener("OP_WarEQUIP_STRENGTHENSTR",updateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutOut",outUpdateHandler);
         _info1QhBtn.removeEventListener("click",clickHandler);
         TheseussoulManager.Instance.removeEventListener("OP_WarEQUIP_STRENGTHENSTR",updateHandler);
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _allNum.text = "0";
         _info1QhBtn.enable = false;
         _maxItem.visible = false;
         _inf1Next.data = null;
         _inf1from.data = null;
         _inf1Metrial.data = null;
         _inf1NameTx.text = "";
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_inf1from.data && _loc2_ == 5)
         {
            updateId(_inf1from.data);
         }
      }
      
      private function updateId(param1:WarFrameItemInfo) : void
      {
         var _loc2_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc3_:WarFrameItemInfo in _loc2_)
         {
            if(_loc3_.strengthen == param1.strengthen + 1 && _loc3_.templateId == param1.templateId && _loc3_.reform == param1.reform && _loc3_.isEquip == param1.isEquip)
            {
               updateUI(_loc3_.id);
            }
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_inf1from.data)
         {
            TheseussoulManager.Instance.doWarFrameParam(5,_inf1from.data.id);
         }
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_);
         }
      }
      
      private function updateUI(param1:int) : void
      {
         var _loc11_:Array = null;
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc10_:GoodsInfo = null;
         var _loc9_:WarFrameItemInfo = TheseussoulManager.Instance.model.armorBagDic[param1] as WarFrameItemInfo;
         TheseussoulManager.Instance.warsoulModel.currWarInsSelectInfo = _loc9_;
         _inf1from.data = _loc9_;
         if(_loc9_.warStrengthTempInfo.Cost)
         {
            _loc11_ = _loc9_.warStrengthTempInfo.Cost.split("|");
            _loc3_ = int(_loc11_[1].split(",")[1]);
            _loc6_ = _loc11_[0].split(",");
            _loc4_ = int(_loc6_[0]);
            _allNum.text = _loc3_ + "";
            if(_loc4_ > 0)
            {
               _loc10_ = new GoodsInfo();
               _loc10_.templateId = _loc4_;
               _loc10_.count = int(_loc6_[1]);
               _inf1Metrial.data = _loc10_;
            }
            else
            {
               _inf1Metrial.data = null;
            }
         }
         var _loc7_:String = _loc9_.warTempInfo.TemplateName;
         _loc7_ = _loc7_ + ("+" + _loc9_.strengthen);
         var _loc8_:String = GoodsHelp.getGoodColorString(_loc9_.reform);
         var _loc5_:String = AttributeUtils.getColorStr(_loc7_,_loc8_,false);
         _inf1NameTx.htmlText = _loc5_;
         var _loc2_:WarFrameItemInfo = _loc9_.clone();
         _loc2_.strengthen += 1;
         if(_loc2_.strengthen > _loc9_.warReformTempInfo.StrengthenLimit)
         {
            _maxItem.visible = true;
            _arrow.visible = false;
            _inf1Next.visible = false;
            _inf1Next.data = null;
            _allNum.text = "0";
            return;
         }
         _inf1Next.data = _loc2_;
         _inf1Next.setNormalFilter();
         _info1QhBtn.enable = _inf1Metrial.isEnough && _currencyInfo.poseidonCoin.amount >= _loc3_;
         _maxItem.visible = false;
         _arrow.visible = true;
         _inf1Next.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_inf1from && _inf1from.data)
         {
            _inf1from.data.objectId = 0;
            NotificationManager.instance.sendNotification("EventWarFrameInsPutOut",_inf1from.data.id);
         }
         ObjectUtils.disposeObject(_inf1from);
         _inf1from = null;
         ObjectUtils.disposeObject(_inf1Metrial);
         _inf1Metrial = null;
         ObjectUtils.disposeObject(_inf1Next);
         _inf1Next = null;
         ObjectUtils.disposeObject(_inf1NameTx);
         _inf1NameTx = null;
         ObjectUtils.disposeObject(_info1QhBtn);
         _info1QhBtn = null;
         ObjectUtils.disposeViolentMc(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_maxItem);
         _maxItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
   }
}

