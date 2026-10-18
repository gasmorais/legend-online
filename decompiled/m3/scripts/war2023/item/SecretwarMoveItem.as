package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.util.SecretwarBitDataUtil;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretWarManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SecretwarMoveItem extends Sprite
   {
      
      private var _iconBg:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _posFlg:Bitmap;
      
      private var _data:SecretwarPlayInfo;
      
      private var _selfKey:String;
      
      private var _shape:Shape;
      
      public function SecretwarMoveItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _selfKey = _loc1_.userId + "_" + _loc1_.serviceName;
         _iconBg = new Bitmap();
         _posFlg = new Bitmap();
         _headIcon = ComponentFactory.Instance.creatCustomObject("ui.secretwar.headIcon");
         _shape = new Shape();
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawCircle(0,0,16);
         _shape.graphics.endFill();
         addChild(_iconBg);
         addChild(_headIcon);
         addChild(_shape);
         addChild(_posFlg);
         _headIcon.mask = _shape;
         _iconBg.x = -27;
         _iconBg.y = -27;
         _posFlg.x = -15;
         _posFlg.y = -68;
      }
      
      public function playMove() : void
      {
         if(!_data)
         {
            return;
         }
         this.visible = true;
         if(!_data.isMoving)
         {
            return;
         }
         var _loc1_:Point = Point.interpolate(_data.nextPoint,_data.startPos,_data.currmoveFrame / _data.totalmoveFrame);
         _data.currmoveFrame += 1;
         _data.x = _loc1_.x;
         _data.y = _loc1_.y;
         this.x = _loc1_.x;
         this.y = _loc1_.y;
         if(_data.currmoveFrame >= _data.totalmoveFrame)
         {
            _data.isMoving = false;
         }
      }
      
      public function stopMove() : void
      {
         this.visible = false;
      }
      
      public function get data() : SecretwarPlayInfo
      {
         return _data;
      }
      
      public function set data(param1:SecretwarPlayInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _data.nickName = _data.nickName;
            _iconBg.bitmapData = SecretwarBitDataUtil.getMoveIcon(_data.camp);
            if(_data.key == _selfKey)
            {
               _posFlg.bitmapData = SecretwarBitDataUtil.getPosFlg(_data.camp);
            }
            else
            {
               _posFlg.bitmapData = null;
            }
            _headIcon.icon = IconFactory.getHeadIcon(_data.headId,"smallhead",".jpg");
            this.x = _data.x;
            this.y = _data.y;
            trace("出生移动对象初始化位{invalid_utf8=231}{invalid_utf8=189}?:移动步数",_data.moveStep,"{invalid_utf8=229}{invalid_utf8=188}?始位置：",_data.currPoint,"结束位置{invalid_utf8=239}{invalid_utf8=188}?",_data.nextPoint,"当前xy:",_data.x,_data.y);
         }
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

