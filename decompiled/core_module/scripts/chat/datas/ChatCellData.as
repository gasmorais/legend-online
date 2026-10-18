package chat.datas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.engine.ContentElement;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.GraphicElement;
   import flash.text.engine.TextElement;
   import mvc.module.appell.AppellModel;
   import yishi.manager.NotificationManager;
   
   public class ChatCellData implements Disposeable
   {
      
      public var uuid:String;
      
      public var channel:int;
      
      public var userId:int;
      
      public var nickName:String;
      
      public var serverName:String;
      
      public var grades:int;
      
      public var consortiaId:int;
      
      public var vipGrade:int;
      
      public var userType:int;
      
      public var type:int;
      
      public var text:String;
      
      private var _data:Object;
      
      public var faceLink:String;
      
      public var itemId:String;
      
      public var receiverName:String;
      
      public var elementFormat:ElementFormat;
      
      private var _dispatcher:EventDispatcher;
      
      private var _contan:Sprite;
      
      private var _bitmap:Bitmap;
      
      private var _grad:GradientText;
      
      private var _appell:MovieClip;
      
      private var _appellNew:GradientText;
      
      private var _expression:MovieClip;
      
      public function ChatCellData()
      {
         super();
         _dispatcher = new EventDispatcher();
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
      }
      
      public function get cellContentElement() : ContentElement
      {
         var _loc3_:ContentElement = null;
         var _loc2_:String = null;
         var _loc4_:int = 0;
         var _loc1_:Array = null;
         switch(type)
         {
            case 10:
               _bitmap = ComponentFactory.Instance.creatBitmap(faceLink);
               _loc3_ = new GraphicElement(_bitmap,_bitmap.width,_bitmap.height,elementFormat);
               break;
            case 16:
               _bitmap = ComponentFactory.Instance.creatBitmap(faceLink);
               _loc3_ = new GraphicElement(_bitmap,_bitmap.width,_bitmap.height,elementFormat);
               break;
            case 18:
               _appellNew = ComponentFactory.Instance.creatComponentByStylename("appell.apellChatText");
               _loc2_ = this.text;
               _loc4_ = 1;
               _loc1_ = this.text.split("|");
               if(_loc1_.length > 1)
               {
                  _loc2_ = _loc1_[0];
                  _loc4_ = int(_loc1_[1]);
               }
               _appellNew.colors = AppellModel.COLORS[_loc4_ - 1];
               _appellNew.textField.height = 18;
               _appellNew.height = 18;
               _appellNew.htmlText = "<font size=\'12\'>" + _loc2_ + "</font>";
               _appellNew.textField.width = _appellNew.textField.textWidth + 5;
               _appellNew.width = _appellNew.textField.textWidth + 5;
               _appellNew.textSize = _appellNew.textSize;
               _loc3_ = new GraphicElement(_appellNew,_appellNew.textField.textWidth + 5,19,elementFormat);
               break;
            case 11:
               _appell = ComponentFactory.Instance.creat(faceLink);
               _loc3_ = new GraphicElement(_appell,20,18,elementFormat);
               break;
            case 13:
               _bitmap = ComponentFactory.Instance.creatBitmap(faceLink);
               _loc3_ = new GraphicElement(_bitmap,_bitmap.width,_bitmap.height,elementFormat);
               break;
            case 14:
               _bitmap = ComponentFactory.Instance.creatBitmap(faceLink);
               _loc3_ = new GraphicElement(_bitmap,_bitmap.width,_bitmap.height,elementFormat);
               break;
            case 15:
               _bitmap = ComponentFactory.Instance.creatBitmap(faceLink);
               _loc3_ = new GraphicElement(_bitmap,_bitmap.width,_bitmap.height,elementFormat);
               break;
            case 2:
               _loc3_ = new TextElement(text,elementFormat);
               break;
            case 1:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__playerClickHandler);
               break;
            case 9:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__channelClickHandler);
               break;
            case 7:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__consortiaClickHandler);
               break;
            case 8:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__roomClickHandler);
               break;
            case 6:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__starClickHandler);
               break;
            case 27:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__cardClickHandler);
               break;
            case 4:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__equipClickHandler);
               break;
            case 3:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__propClickHandler);
               break;
            case 12:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__VipLinkHandler);
               break;
            case 17:
               _expression = ComponentFactory.Instance.creat(faceLink);
               _loc3_ = new GraphicElement(_expression,20,16,elementFormat);
               break;
            case 19:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__appellLinkClickHandler);
               break;
            case 20:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__roseBackClickHandler);
               break;
            case 21:
            case 22:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__reinforceClickHandler);
               break;
            case 26:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__seekLinkClickHandler);
               break;
            case 25:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__appellWebLinkClickHandler);
               break;
            case 30:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__fishClickHandler);
               break;
            case 110:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__goldRoadClickHandler);
               break;
            case 23:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__cardBackClickHandler);
               break;
            case 111:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__outerCityBossClickHandler);
               break;
            case 112:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__planesDeadHelpHandler);
               break;
            case 113:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__openSaleHandler);
               break;
            case 114:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__openTreasureHandler);
               break;
            case 116:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__shareSpaceTimeHandler);
               break;
            case 117:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__alchemicalInviteHandler);
               break;
            case 31:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__godsEveningGotoHandler);
               break;
            case 118:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__crisisAttackInvateHandler);
               break;
            case 119:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__gameHallInvateHandler);
               break;
            case 120:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__apexTeamInvateHandler);
               break;
            case 121:
               _loc3_ = createLinkTxt();
               _dispatcher.addEventListener("click",__consortiaNewBossHandler);
         }
         return _loc3_;
      }
      
      private function __outerCityBossClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("OUTER_CITY_BOSS_CLICK",this);
      }
      
      private function __addTostage(param1:Event) : void
      {
         var _loc2_:Sprite = param1.currentTarget as Sprite;
         _loc2_.parent.mouseEnabled = false;
      }
      
      private function createLinkTxt() : ContentElement
      {
         _contan = new Sprite();
         _contan.buttonMode = true;
         _contan.mouseChildren = false;
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = "none";
         _loc1_.height = 18;
         _loc1_.selectable = false;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = elementFormat.color;
         _loc2_.underline = type != 1 && type != 9;
         _loc2_.size = 12;
         _loc2_.letterSpacing = elementFormat.trackingLeft;
         _loc1_.defaultTextFormat = _loc2_;
         if(userType != 2 && vipGrade > 0)
         {
            _grad = ComponentFactory.Instance.creatComponentByStylename("chat.VipText");
            _grad.textField = _loc1_;
            _grad.text = text;
            _loc1_.width = _loc1_.textWidth + 4;
            _contan.addChild(_grad);
            _grad.y = -_grad.height / 2;
            return new GraphicElement(_contan,_loc1_.width,_contan.height,elementFormat,_dispatcher);
         }
         _loc1_.text = text;
         _loc1_.width = _loc1_.textWidth + 4;
         _contan.addChild(_loc1_);
         return new GraphicElement(_contan,_contan.width,_contan.height,elementFormat,_dispatcher);
      }
      
      private function __playerClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("PLAYER_NAME_CLICK",this);
      }
      
      private function __channelClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CHANNEL_CLICK",this);
      }
      
      private function __consortiaClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CONSORTIA_CLICK",this);
      }
      
      private function __roomClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("ROOM_CLICK",this);
      }
      
      private function __starClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("STAR_CLICK",this);
      }
      
      private function __cardBackClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CARD_BACK_CLICK",this);
      }
      
      private function __cardClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CARD_CLICK",this);
      }
      
      private function __equipClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("EQUIP_CLICK",this);
      }
      
      private function __propClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("PROP_CLICK",this);
      }
      
      private function __shareSpaceTimeHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("SHARE_SPACE_TIME_CLICK",this);
      }
      
      private function __VipLinkHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("VIP_LINK_CLICK",this);
      }
      
      private function __seekLinkClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("SEEK_LINK_CLICK",this);
      }
      
      private function __appellLinkClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("APPELL_LINK_CLICK",this);
      }
      
      private function __appellWebLinkClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = String(this.data);
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         navigateToURL(_loc2_,"_blank");
      }
      
      private function __roseBackClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("ROSE_BACK_CLICK",this);
      }
      
      private function __reinforceClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("REINFORCE_CLICK",this);
      }
      
      private function __fishClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("FISH_CLICK",this);
      }
      
      private function __goldRoadClickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("GOLDROAD_CLICK",this);
      }
      
      private function __planesDeadHelpHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("PLANES_DEAD_HELP_CLICK",this);
      }
      
      private function __godsEveningGotoHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("GODS_EVENING_GOTO",this);
      }
      
      private function __openSaleHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("OPEN_SALE_CLICK",this);
      }
      
      private function __openTreasureHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("OPEN_TREASURE_CLICK",this);
      }
      
      private function __alchemicalInviteHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("ALCHEMICAL_INVITE_CLICK",this);
      }
      
      private function __crisisAttackInvateHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CRISIS_ATTACK_INVATE_CLICK",this);
      }
      
      private function __gameHallInvateHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("GAME_HALLK_INVATE_CLICK",this);
      }
      
      private function __apexTeamInvateHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("APEX_TEAM_INVATE_CLICK",this);
      }
      
      private function __consortiaNewBossHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("CONSORTIA_NEW_BOSS_CLICK",this);
      }
      
      public function dispose() : void
      {
         _dispatcher.removeEventListener("click",__propClickHandler);
         _dispatcher.removeEventListener("click",__equipClickHandler);
         _dispatcher.removeEventListener("click",__starClickHandler);
         _dispatcher.removeEventListener("click",__roomClickHandler);
         _dispatcher.removeEventListener("click",__consortiaClickHandler);
         _dispatcher.removeEventListener("click",__playerClickHandler);
         _dispatcher.removeEventListener("click",__VipLinkHandler);
         _dispatcher.removeEventListener("click",__channelClickHandler);
         _dispatcher.removeEventListener("click",__appellLinkClickHandler);
         _dispatcher.removeEventListener("click",__roseBackClickHandler);
         _dispatcher.removeEventListener("click",__reinforceClickHandler);
         _dispatcher.removeEventListener("click",__fishClickHandler);
         _dispatcher.removeEventListener("click",__goldRoadClickHandler);
         _dispatcher.removeEventListener("click",__outerCityBossClickHandler);
         _dispatcher.removeEventListener("click",__planesDeadHelpHandler);
         _dispatcher.removeEventListener("click",__openTreasureHandler);
         _dispatcher.removeEventListener("click",__shareSpaceTimeHandler);
         _dispatcher.removeEventListener("click",__alchemicalInviteHandler);
         _dispatcher.removeEventListener("click",__godsEveningGotoHandler);
         _dispatcher.removeEventListener("click",__crisisAttackInvateHandler);
         _dispatcher.removeEventListener("click",__gameHallInvateHandler);
         _dispatcher.removeEventListener("click",__apexTeamInvateHandler);
         _dispatcher.removeEventListener("click",__consortiaNewBossHandler);
         grades = 0;
         channel = 0;
         userId = 0;
         serverName = "";
         nickName = "";
         text = "";
         itemId = "";
         receiverName = "";
         consortiaId = 0;
         vipGrade = 0;
         type = 0;
         userType = 0;
         _data = null;
         elementFormat = null;
         ObjectUtils.disposeObject(_grad);
         _grad = null;
         ObjectUtils.disposeObject(_contan);
         _contan = null;
         ObjectUtils.disposeObject(_bitmap);
         _bitmap = null;
         ObjectUtils.disposeViolentMc(_appell);
         _appell = null;
         ObjectUtils.disposeViolentMc(_expression);
         _expression = null;
         faceLink = "";
      }
   }
}

