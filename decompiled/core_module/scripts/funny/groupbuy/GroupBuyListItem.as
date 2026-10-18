package funny.groupbuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shop.BuyInfo;
   import com.road.yishi.proto.shop.ShopMsg;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import mvc.module.shop.MainShopInfo;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class GroupBuyListItem extends Component
   {
      
      private var _bg:DisplayObject;
      
      private var _bgOver:DisplayObject;
      
      private var _txt:FilterFrameText;
      
      private var _isSelected:Boolean = false;
      
      private var _info:MainShopInfo;
      
      private var _type:int;
      
      public function GroupBuyListItem(param1:MainShopInfo, param2:int)
      {
         _type = param2;
         _info = param1;
         this.buttonMode = true;
         super();
         initUI();
         addEvents();
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(_isSelected)
         {
            _bgOver.visible = true;
            sendMsg();
         }
         else
         {
            _bgOver.visible = false;
         }
      }
      
      private function initUI() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.groupbuy.groupbuyitembg");
         this.addChild(_bg);
         _bgOver = ComponentFactory.Instance.creat("asset.groupbuy.groupbuyitembgOver");
         _bgOver.x = 1;
         this.addChild(_bgOver);
         _bgOver.visible = false;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_info.templateId);
         var _loc2_:String = "groupbuy.listItem.name" + _loc1_.Profile;
         _txt = ComponentFactory.Instance.creatComponentByStylename(_loc2_);
         this.addChild(_txt);
         _txt.text = _loc1_.TemplateName;
         if(_txt.text.length > 27)
         {
            _txt.text = _txt.text.substr(0,26) + "...";
         }
         if(_type == 2)
         {
            _bg.width = 187;
            _bgOver.width = 187;
            _txt.width = 187;
         }
      }
      
      private function addEvents() : void
      {
         this.addEventListener("mouseOver",overHandler);
         this.addEventListener("mouseOut",outHandler);
      }
      
      private function sendMsg() : void
      {
         var _loc2_:PackageOut = null;
         _loc2_ = new PackageOut(8645);
         var _loc1_:ShopMsg = new ShopMsg();
         _loc1_.payType = 3;
         _loc1_.buyInfo = new BuyInfo();
         _loc1_.buyInfo.goodId = _info.id;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      protected function outHandler(param1:MouseEvent) : void
      {
         if(_isSelected)
         {
            return;
         }
         _bgOver.visible = false;
      }
      
      protected function overHandler(param1:MouseEvent) : void
      {
         _bgOver.visible = true;
      }
      
      private function removeEvents() : void
      {
         this.removeEventListener("mouseOver",overHandler);
         this.removeEventListener("mouseOut",outHandler);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _info = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bgOver);
         _bgOver = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

