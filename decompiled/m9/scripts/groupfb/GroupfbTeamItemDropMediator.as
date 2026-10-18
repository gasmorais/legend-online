package groupfb
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.marriage.PropertyListMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import managers.GroupfbManager;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.PlayerMenu;
   
   public class GroupfbTeamItemDropMediator implements IMediator
   {
      
      protected var _cell:GroupfbTeamItem;
      
      private var _menu:PlayerMenu;
      
      public function GroupfbTeamItemDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as GroupfbTeamItem;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell.addEventListener("mouseDown",__mouseDowaHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell.removeEventListener("mouseDown",__mouseDowaHandler);
         _cell = null;
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
      }
      
      private function __mouseDowaHandler(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(canDrag() == false)
         {
            showMenu();
            param1.stopImmediatePropagation();
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",_cell);
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag();
         }
      }
      
      protected function starItemDrag() : void
      {
         SoundManager.instance.play("003");
         var _loc2_:Sprite = getDragIconObj();
         if(!_loc2_)
         {
            return;
         }
         _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
         var _loc1_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc2_,
            "type":"down"
         });
         _loc1_.onDrop = beDropHitCallBack;
         _loc1_.dropChecks = [GroupfbTeamItem,Frame,Stage];
         _cell.setGrayFilter();
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:GroupfbTeamItem = null;
         var _loc2_:PropertyListMsg = null;
         if(_cell == null || _cell.data == null)
         {
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            return;
         }
         if(param1.dropTarget is GroupfbTeamItem)
         {
            _loc3_ = param1.dropTarget as GroupfbTeamItem;
            if(_loc3_.team != _cell.team)
            {
               _loc2_ = new PropertyListMsg();
               _loc2_.property1 = _cell.data.userId;
               if(_loc3_.data)
               {
                  _loc2_.property2 = _loc3_.data.userId;
               }
               GroupfbSender.changeTeam(_loc2_);
            }
            else if(_loc3_.data && _loc3_.data.userId == _cell.data.userId)
            {
               showMenu();
            }
         }
         param1.stopImmediatePropagation();
         _cell.setNormalFilter();
      }
      
      private function getDragIconObj() : Sprite
      {
         var _loc3_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc5_:Matrix = null;
         var _loc4_:Bitmap = null;
         if(_cell && _cell.data)
         {
            _loc3_ = new Sprite();
            _loc1_ = _cell.getRect(_cell);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc5_ = new Matrix();
            _loc5_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_cell,_loc5_);
            _loc4_ = new Bitmap(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = _loc2_.width;
            _loc4_.height = _loc2_.height;
            _loc3_.addChild(_loc4_);
            return _loc3_;
         }
         return null;
      }
      
      private function showMenu() : void
      {
         var _loc2_:ThaneInfo = null;
         var _loc1_:Point = null;
         if(_cell && _cell.data)
         {
            _loc2_ = new ThaneInfo();
            _loc2_.userId = _cell.data.userId;
            _loc2_.nickName = _cell.data.nickName;
            _loc2_.consortiaName = _cell.data.consortiaName;
            _loc2_.fightingCapacity = _cell.data.fightCapacity;
            _loc2_.grades = _cell.data.grades;
            if(GroupfbManager.instance.model.isCaptain && _cell.data.userId != playerInfo.userId)
            {
               _menu = new PlayerMenu(false,false,false,false,false,false,false,true);
            }
            else
            {
               _menu = new PlayerMenu();
            }
            _menu.x = StageReferance.stage.mouseX;
            _loc1_ = _cell.localToGlobal(new Point(0,_cell.height));
            _menu.y = _loc1_.y - 10;
            _menu.setData(_loc2_);
            LayerManager.Instance.addToLayer(_menu,7);
         }
      }
      
      private function canDrag() : Boolean
      {
         return GroupfbManager.instance.model.isCaptain && (SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

