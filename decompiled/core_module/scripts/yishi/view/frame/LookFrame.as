package yishi.view.frame
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class LookFrame extends Frame implements IManualSize
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _figureBack:ScaleFrameImage;
      
      private var _figure:ShowAvatar;
      
      private var _thane:ThaneInfo;
      
      private var _buyWingBtn:IconButton;
      
      private var _buyWingFunction:Function;
      
      public var buyData:Vector.<ShopGoodsInfo>;
      
      public function LookFrame()
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
         _back1 = ComponentFactory.Instance.creatComponentByStylename("shop.LookFrameBack");
         _figureBack = ComponentFactory.Instance.creatComponentByStylename("shop.HeroFigureBack");
         _buyWingBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyWingBtn");
         _figure = new ShowAvatar(true);
         _figure.x = 50;
         _figure.y = 30;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         addToContent(_back1);
         addToContent(_figureBack);
         _figureBack.setFrame(2);
         addToContent(_figure);
         addToContent(_buyWingBtn);
         titleText = LanguageMgr.GetTranslation("shop.LookFrame.titleText");
      }
      
      private function set data(param1:Vector.<GoodsTemplateInfo>) : void
      {
         if(!_thane)
         {
            _thane = new ThaneInfo();
            _thane.hairEquipAvata = thane.hairEquipAvata;
            _thane.bodyEquipAvata = thane.bodyEquipAvata;
            _thane.armsEquipAvata = thane.armsEquipAvata;
            _thane.templateId = thane.templateId;
         }
         if(param1.length > 3 && param1[3])
         {
            _thane.hairFashionAvata = param1[3].Avata;
         }
         if(param1.length > 2 && param1[2])
         {
            _thane.bodyFashionAvata = param1[2].Avata;
         }
         if(param1.length > 1 && param1[1])
         {
            _thane.armsFashionAvata = param1[1].Avata;
         }
         if(param1.length > 0 && param1[0])
         {
            _thane.wingAvata = param1[0].Avata;
         }
         refreshHeroFigure();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyWingBtn.addEventListener("click",__buyWingHandler);
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buyWingBtn.removeEventListener("click",__buyWingHandler);
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         _buyWingFunction = null;
      }
      
      private function __buyWingHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_buyWingFunction != null)
         {
            _buyWingFunction(buyData);
            return;
         }
         _loc2_ = LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.buyFailed");
         MessageTipManager.instance().show(_loc2_);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function refreshHeroFigure() : void
      {
         _figureBack.setFrame(_thane.templateInfo.Job);
         _figure.data = _thane;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show(param1:Array) : void
      {
         if(param1.length > 0 && param1[0])
         {
            data = param1[0];
         }
         if(param1.length > 1 && param1[1])
         {
            buyData = param1[1];
         }
         if(param1.length > 2 && param1[2])
         {
            _buyWingFunction = param1[2];
         }
         if(buyData == null)
         {
            _buyWingBtn.visible = false;
         }
         else
         {
            _buyWingBtn.visible = true;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,408,408);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         buyData = null;
         if(_back1)
         {
            _back1.dispose();
         }
         _back1 = null;
         if(_figureBack)
         {
            _figureBack.dispose();
         }
         _figureBack = null;
         if(_figure)
         {
            _figure.dispose();
         }
         _figure = null;
         if(_buyWingBtn)
         {
            _buyWingBtn.dispose();
         }
         _buyWingBtn = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_figureBack);
         _figureBack = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_buyWingBtn);
         _buyWingBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

