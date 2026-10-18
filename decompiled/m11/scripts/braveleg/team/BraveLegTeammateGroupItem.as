package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.braveleg.BraveLegModel;
   import yishi.filter.UIFilter;
   import yishi.manager.BraveLegManager;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.HeadIconCell;
   
   public class BraveLegTeammateGroupItem extends Component
   {
      
      private var _headBg:ScaleBitmapImage;
      
      private var _groupItemTxt:Image;
      
      private var _head:HeadIconCell;
      
      private var _pos:ScaleFrameImage;
      
      private var _data:Object;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _hit:Sprite;
      
      public function BraveLegTeammateGroupItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _headBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupItemHeadBg");
         _groupItemTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupItemTxt");
         _head = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupItemHead");
         _pos = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupPos");
         var _loc2_:BitmapData = new BitmapData(_head.iconWidth,_head.iconHeight,true,16777215);
         _loc2_.floodFill(0,0,16777215);
         var _loc1_:Bitmap = new Bitmap(_loc2_);
         _hit = new Sprite();
         _hit.addChild(_loc1_);
         _hit.x = _head.x;
         _hit.y = _head.y;
         addChild(_headBg);
         addChild(_groupItemTxt);
         addChild(_head);
         addChild(_pos);
         addChild(_hit);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseDown",__onMouseDownHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__onMouseDownHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_headBg);
         _headBg = null;
         ObjectUtils.disposeObject(_groupItemTxt);
         _groupItemTxt = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_pos);
         _pos = null;
         ObjectUtils.disposeObject(_hit);
         _hit = null;
         _data.player = null;
         ObjectUtils.disposeObject(_hit);
         _hit = null;
         _model = null;
         super.dispose();
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         if(_data.player)
         {
            _pos.setFrame(param1.player.pos);
            _pos.visible = true;
            _head.headId = _data.player.headId > 0 ? _data.player.headId : _data.player.sexJob;
            _head.visible = true;
            _groupItemTxt.visible = false;
         }
         else
         {
            _pos.visible = false;
            _head.headId = 0;
            _head.visible = false;
            _groupItemTxt.visible = _model.teamInfo.isMaster;
         }
      }
      
      private function __onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:GameDrag = null;
         if(_data.player && _model.teamInfo.isMaster)
         {
            SoundManager.instance.play("003",true);
            _loc3_ = getDragIconObj();
            if(!_loc3_)
            {
               return;
            }
            _loc2_ = DragManager.getInstance().starDrag(this,{
               "icon":_loc3_,
               "type":"down",
               "lockCenter":true
            });
            _loc2_.onDrop = onDragStop;
            _loc2_.dropChecks = [BraveLegTeammateGroupItem,Frame,stage];
            filters = [UIFilter.getGrayFilter(),UIFilter.getLightingFilter()];
         }
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:HeadIconCell = null;
         if(_data.player)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("braveleg.GroupItemHead");
            _loc1_.x = _loc1_.y = 0;
            _loc1_.headId = _data.player.headId > 0 ? _data.player.headId : _data.player.sexJob;
            return _loc1_;
         }
         return null;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:BraveLegTeammateGroupItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is BraveLegTeammateGroupItem)
            {
               _loc2_ = param1.dropTarget as BraveLegTeammateGroupItem;
               if(_loc2_.data.groupId != _data.groupId)
               {
                  BraveLegManager.instance.requestEditTeam(_data.player.userId,_loc2_.data.groupId);
               }
            }
         }
         param1.stopImmediatePropagation();
         ObjectUtils.disposeObject(param1.dragIcon);
         filters = null;
      }
      
      override public function get width() : Number
      {
         return 60;
      }
      
      override public function get height() : Number
      {
         return 60;
      }
   }
}

