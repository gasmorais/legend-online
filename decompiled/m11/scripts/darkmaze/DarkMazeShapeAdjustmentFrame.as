package darkmaze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.module.children.ChildData;
   import mvc.module.darkmaze.DarkMazeBattleChildInfo;
   import mvc.module.darkmaze.DarkMazeChildPosInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   
   public class DarkMazeShapeAdjustmentFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _spliteImg:Image;
      
      private var _bottoms:Array;
      
      private var _scrollPanle:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var preFormation:String;
      
      private var posArray:Array = [[],[1,3],[4,6],[7,9],[10,12]];
      
      private var _rect:Rectangle;
      
      public function DarkMazeShapeAdjustmentFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:DarkMazeShapAdjustmentItemView = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapeAdjustmentFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapeAdjustmentFrame.back");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapeAdjustmentFrame.vBox");
         _spliteImg = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapeAdjustmentFrame.spliteImg");
         _scrollPanle = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapeAdjustmentFrame.scrollPanle");
         addToContent(_border);
         addToContent(_back);
         addToContent(_spliteImg);
         _scrollPanle.setView(_vBox);
         _bottoms = [];
         var _loc1_:Array = [{
            "x":501,
            "y":261
         },{
            "x":459,
            "y":319
         },{
            "x":416,
            "y":371
         },{
            "x":366,
            "y":421
         },{
            "x":710,
            "y":261
         },{
            "x":668,
            "y":319
         },{
            "x":625,
            "y":371
         },{
            "x":575,
            "y":421
         }];
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new DarkMazeShapAdjustmentItemView(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addToContent(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
         addToContent(_vBox);
         addToContent(_scrollPanle);
         this.titleText = LanguageMgr.GetTranslation("ChildPveFrame.title");
      }
      
      private function uintView() : void
      {
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_spliteImg);
         _spliteImg = null;
         ObjectUtils.disposeObject(_scrollPanle);
         _scrollPanle = null;
         for each(_loc1_ in _bottoms)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _bottoms = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.addEventListener("DARK_MAZE_BATTLE_INFO_UPDATA",__childformationChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.removeEventListener("DARK_MAZE_BATTLE_INFO_UPDATA",__childformationChangeHandler);
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         if(param1.data && param1.data.data && param1.data.data.childId)
         {
            _loc4_ = int(param1.data.data.childId);
         }
         var _loc2_:Array = getCanNotDrops(_loc4_);
         for each(var _loc3_:DarkMazeShapAdjustmentItemView in _bottoms)
         {
            if(_loc2_.indexOf(_loc3_.pos) == -1)
            {
               _loc3_.setBottomVisible(true);
               _loc3_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_:DarkMazeShapAdjustmentItemView in _bottoms)
         {
            _loc2_.setBottomVisible(false);
            _loc2_.normal();
            if(_loc2_.data)
            {
               _loc3_[_loc2_.pos] = _loc2_.data.childId;
            }
            else
            {
               _loc3_[_loc2_.pos] = 0;
            }
         }
         updateToPlayerInfo(_loc3_);
         __childformationChangeHandler(null);
      }
      
      private function updateToPlayerInfo(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         for(var _loc4_:String in param1)
         {
            _loc3_ = int(param1[_loc4_]);
            _loc2_ += _loc4_ + "," + _loc3_ + "|";
         }
         _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf("|"));
         if(preFormation != _loc2_)
         {
            DarkMazeManager.instance.darkMazeOperation(4,0,0,_loc2_);
            preFormation = _loc2_;
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:DarkMazeShapAdjustmentHeadView = null;
         var _loc4_:DarkMazeBattleChildInfo = null;
         var _loc6_:ChildData = null;
         var _loc5_:int = 0;
         var _loc3_:Array = darkmazeModel.childList;
         _vBox.disposeAllChildren();
         _scrollPanle.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc1_ = new DarkMazeShapAdjustmentHeadView();
            _loc4_ = _loc3_[_loc5_] as DarkMazeBattleChildInfo;
            if(_loc4_)
            {
               _loc1_.currentHp = _loc4_.currentHp;
               _loc1_.totalHp = _loc4_.totalHp;
               _loc6_ = darkmazeModel.getChildDataById(_loc4_.childId);
               if(_loc4_.childId > 0)
               {
                  _loc1_.fightValue = _loc4_.fightValue;
               }
               else if(_loc6_)
               {
                  _loc1_.fightValue = _loc6_.fightValue;
               }
               _loc1_.data = _loc6_;
            }
            _vBox.addChild(_loc1_);
            _loc5_++;
         }
         _scrollPanle.commitChanges();
         _scrollPanle.invalidateViewport();
         var _loc7_:int = 0;
         for each(var _loc2_:DarkMazeShapAdjustmentItemView in _bottoms)
         {
            _loc2_.setBottomVisible(false);
            _loc7_ = getChildIdByPos(_loc2_.pos);
            _loc2_.data = darkmazeModel.getChildDataById(_loc7_);
         }
         __childformationChangeHandler(null);
      }
      
      private function getChildIdByPos(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:DarkMazeChildPosInfo = null;
         var _loc2_:int = int(darkmazeModel.battleArray.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = darkmazeModel.battleArray[_loc3_];
            if(_loc4_.pos == param1)
            {
               return _loc4_.childId;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function __childformationChangeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:DarkMazeShapAdjustmentHeadView = null;
         var _loc4_:int = 0;
         var _loc2_:Array = darkmazeModel.battleChildIdList;
         _loc4_ = 0;
         while(_loc4_ < _vBox.numChildren)
         {
            _loc3_ = _vBox.getChildAt(_loc4_) as DarkMazeShapAdjustmentHeadView;
            if(_loc3_)
            {
               _loc3_.enable = true;
               if(_loc3_.data && _loc2_ && _loc2_.indexOf(_loc3_.data.childId) >= 0)
               {
                  _loc3_.enable = false;
               }
            }
            _loc4_++;
         }
      }
      
      private function get darkmazeModel() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      private function getCanNotDrops(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:DarkMazeShapAdjustmentItemView in _bottoms)
         {
         }
         return _loc2_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,850,495);
         }
         return _rect;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         DragManager.getInstance().stopDrag();
         KeyBoardRegister.instance.keyEnable = false;
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

