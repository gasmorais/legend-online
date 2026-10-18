package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusWarIntensifyCell;
   import theseus.war.item.TheseusWarMaxItem;
   import theseus.war.item.TheseusWarMetrailCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.WarSoulStarTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class TheseusWarIntenPageView extends Sprite
   {
      
      public var _inf1from:TheseusWarIntensifyCell;
      
      public var _inf1Metrial:TheseusWarMetrailCell;
      
      public var _inf1Next:TheseusWarIntensifyCell;
      
      public var _inf1NameTx:FilterFrameText;
      
      public var _info1QhBtn:IconButton;
      
      private var _arrow:MovieClip;
      
      private var _maxItem:TheseusWarMaxItem;
      
      public function TheseusWarIntenPageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _inf1from = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.inf1from");
         _inf1Metrial = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.inf1Metrial");
         _inf1Next = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.inf1Next");
         _inf1NameTx = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.inf1NameTx");
         _info1QhBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.info1QhBtn");
         _arrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensify1Row");
         _maxItem = ComponentFactory.Instance.creatCustomObject("ui.theseus.intensifyMaxItem");
         _maxItem.redStr(LanguageMgr.GetTranslation("theseus.war.insMaxTip"));
         _maxItem.titleStr(LanguageMgr.GetTranslation("theseus.war.insMaxTitle"));
         _maxItem.updateTitlePos(34,2);
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
         _inf1Next.defaultStr = LanguageMgr.GetTranslation("theseus.war.intensifyYL");
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         _info1QhBtn.addEventListener("click",clickHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",updateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         _info1QhBtn.removeEventListener("click",clickHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",updateHandler);
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
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
         if(_inf1from.data && _loc2_ == 12)
         {
            updateUI(_inf1from.data.id);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_inf1from.data)
         {
            TheseussoulManager.Instance.doWarsoulParam(12,-1,_inf1from.data.id);
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
         var _loc8_:GoodsInfo = null;
         var _loc9_:WarSoulStarTempInfo = null;
         var _loc2_:TheseusWarsoulItemInfo = null;
         var _loc10_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = _loc10_;
         _inf1from.data = _loc10_;
         var _loc5_:Array = _loc10_.warStrengthTempInfo.NeedItem.split(",");
         var _loc3_:int = int(_loc5_[0]);
         if(_loc3_ > 0)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc3_;
            _loc8_.count = int(_loc5_[1]);
            _inf1Metrial.data = _loc8_;
         }
         else
         {
            _inf1Metrial.data = null;
         }
         var _loc6_:String = _loc10_.warTempInfo.Name;
         _loc6_ = _loc6_ + ("+" + _loc10_.strengthen);
         var _loc7_:String = GoodsHelp.getGoodColorString(_loc10_.warTempInfo.Profile);
         var _loc4_:String = AttributeUtils.getColorStr(_loc6_,_loc7_,false);
         _inf1NameTx.htmlText = _loc4_;
         if(_loc10_.warStartempInfo.MaxGrade <= _loc10_.strengthen)
         {
            _info1QhBtn.enable = false;
            _arrow.visible = false;
            _inf1Next.visible = false;
            _maxItem.visible = true;
            _loc9_ = TempleteManager.instance.warsoulStarCate.getTemp(_loc10_.warSoulId,_loc10_.star + 1);
            if(_loc9_)
            {
               _maxItem.isShowRedTip = true;
            }
            else
            {
               _maxItem.isShowRedTip = false;
            }
         }
         else
         {
            _loc2_ = _loc10_.clone();
            _loc2_.strengthen += 1;
            _inf1Next.data = _loc2_;
            _info1QhBtn.enable = _inf1Metrial.isEnough;
            _maxItem.visible = false;
            _arrow.visible = true;
            _inf1Next.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_inf1from && _inf1from.data)
         {
            _inf1from.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_inf1from.data.id);
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

