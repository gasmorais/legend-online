package marry.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.marry.MarryRoomInfo;
   import mvc.module.marry.MarrySender;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class MarryRoomItem extends Sprite implements Disposeable
   {
      
      private var _info:MarryRoomInfo;
      
      private var _bg:MutipleImage;
      
      private var _numTxt:GradientText;
      
      private var _typeImg:ScaleFrameImage;
      
      private var _nickNameA:GradientText;
      
      private var _nickNameB:GradientText;
      
      private var _lockImg:Bitmap;
      
      private var _nullRoom:Bitmap;
      
      private var _hit:Sprite;
      
      private var _loveImg:Image;
      
      private var _effect:MovieClip;
      
      public function MarryRoomItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.bg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.numTxt");
         _typeImg = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.typeImg");
         _nickNameA = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.nickNameA");
         _nickNameB = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.nickNameB");
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.core.RoomLockImg");
         _nullRoom = ComponentFactory.Instance.creatBitmap("asset.marry.nullRoom");
         _loveImg = ComponentFactory.Instance.creatComponentByStylename("MarryRoomItem.loveImage");
         addChild(_bg);
         addChild(_typeImg);
         addChild(_nickNameA);
         addChild(_nickNameB);
         addChild(_loveImg);
         addChild(_lockImg);
         _lockImg.x = 184;
         _lockImg.y = 145;
         addChild(_nullRoom);
         addChild(_numTxt);
         buttonMode = true;
         setHitArea();
      }
      
      private function setHitArea() : void
      {
         _hit = new Sprite();
         addChild(_hit);
         _hit.graphics.beginFill(16777215,0);
         _hit.graphics.drawRect(_bg.x,_bg.y,_bg.width,_bg.height);
         _hit.graphics.endFill();
         hitArea = _hit;
      }
      
      public function set info(param1:MarryRoomInfo) : void
      {
         _info = param1;
         refreshView();
         if(isMine)
         {
            play();
         }
         else
         {
            stop();
         }
      }
      
      private function refreshView() : void
      {
         if(_info == null)
         {
            setRoomState(false);
         }
         else
         {
            setRoomState(true);
            _nickNameA.text = _info.nickNameA;
            _nickNameB.text = _info.nickNameB;
            _numTxt.text = "No " + _info.property3;
            _typeImg.setFrame(_info.property2);
            _lockImg.visible = _info.property1;
         }
      }
      
      private function setRoomState(param1:Boolean) : void
      {
         _nullRoom.visible = !param1;
         _bg.visible = param1;
         _nickNameA.visible = param1;
         _nickNameB.visible = param1;
         _loveImg.visible = param1;
         _numTxt.visible = param1;
         _typeImg.visible = param1;
         _lockImg.visible = param1;
      }
      
      private function play() : void
      {
         if(_effect == null)
         {
            _effect = ComponentFactory.Instance.creat("asset.marry.roomItemShine");
            _effect.x = 120;
            _effect.y = 102;
         }
         _effect.gotoAndPlay(1);
         if(_effect.parent == null)
         {
            addChild(_effect);
         }
      }
      
      private function stop() : void
      {
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = undefined;
         if(_info)
         {
            _loc3_ = _info.userIdA + "_" + _info.userIdB;
            if(_info.property1 && _info.userIdA != playerInfo.userId && _info.userIdB != playerInfo.userId)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
               _loc2_.backCall = enterPassWordCall;
               _loc2_.show(_info.property3);
            }
            else
            {
               MarrySender.enterWeddingRoom(_loc3_);
            }
         }
      }
      
      private function enterPassWordCall(param1:int, param2:String) : void
      {
         if(param1 == _info.property3)
         {
            MarrySender.enterWeddingRoom(_info.userIdA + "_" + _info.userIdB,param2);
         }
      }
      
      private function get isMine() : Boolean
      {
         if(!_info)
         {
            return false;
         }
         if(_info.userIdA == playerInfo.userId || _info.userIdB == playerInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _info = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_typeImg);
         _typeImg = null;
         ObjectUtils.disposeObject(_nickNameA);
         _nickNameA = null;
         ObjectUtils.disposeObject(_nickNameB);
         _nickNameB = null;
         ObjectUtils.disposeObject(_loveImg);
         _loveImg = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_nullRoom);
         _nullRoom = null;
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         if(_hit)
         {
            _hit.graphics.clear();
         }
         _hit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

