package gemmaze.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.GemMazeEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.gemmaze.GemMazeModel;
   import yishi.filter.UIFilter;
   import yishi.manager.GemMazeManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GemMazeBoxView extends Sprite implements Disposeable
   {
      
      private static const _boxCount:int = 5;
      
      private static const _MCEFF_MINY:int = 592;
      
      private static const BOX_INDEX_ARR:Array = [1,2,4,8,16];
      
      private var _efMc:MovieClip;
      
      private var SORT_INDEX_ARRAY:Array = [];
      
      private var _boxArr:Array;
      
      private var _model:GemMazeModel;
      
      private var _flagBitmap:Bitmap;
      
      private var _prizeView:GemMazePrizeView;
      
      private var clickBoxIndex:int;
      
      public var maskTopPos:int;
      
      public function GemMazeBoxView()
      {
         super();
         initView();
      }
      
      private function initEvent() : void
      {
         GemMazeManager.Instance.addEventListener("GEMMAZE_UPDATE_BOX_STATUS",updateBox);
         GemMazeManager.Instance.addEventListener("GEMMAZE_PLAYER_BOX_GOODS",onPlayer);
         GemMazeManager.Instance.addEventListener("GEMMAZE_ADD_INTERGAL",onUpdate);
      }
      
      private function removeEvent() : void
      {
         GemMazeManager.Instance.removeEventListener("GEMMAZE_UPDATE_BOX_STATUS",updateBox);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_PLAYER_BOX_GOODS",onPlayer);
         GemMazeManager.Instance.removeEventListener("GEMMAZE_ADD_INTERGAL",onUpdate);
      }
      
      private function onPlayer(param1:GemMazeEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.data as Array;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            setTimeout(createIconAnime,200 * _loc3_,_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function createIconAnime(param1:int) : void
      {
         if(this.stage == null)
         {
            return;
         }
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc2_.icon = IconFactory.getGoodsIconByTID(param1);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var bagPoint:Point;
         var icon:BaseIconView = param1;
         var point:Point = new Point(_boxArr[clickBoxIndex].x,_boxArr[clickBoxIndex].y);
         icon.x = this.localToGlobal(point).x;
         icon.y = this.localToGlobal(point).y;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagPoint = this.localToGlobal(new Point(745,200));
         if(icon)
         {
            TweenMax.to(icon,1,{
               "delay":0.4,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":bagPoint.x + 40,
                  "y":bagPoint.y + 30
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[icon]
            });
         }
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onUpdate(param1:GemMazeEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.data;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            setTimeout(showAddIntergal,200 * _loc3_,_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function showAddIntergal(param1:int) : void
      {
         var _loc4_:String = "#FFFFFF";
         if(param1 > 20)
         {
            _loc4_ = "#FFFF00";
         }
         if(param1 > 80)
         {
            _loc4_ = "#CEA031";
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.size = 18;
         _loc2_.bold = true;
         _loc2_.font = "Arial";
         var _loc3_:TextField = new TextField();
         _loc3_.textColor = 16777215;
         _loc3_.htmlText = LanguageMgr.GetTranslation("gemMaze.GemMazeBoxView.showAddIntergal",_loc4_,param1);
         _loc3_.x = 90;
         _loc3_.y = 395;
         _loc3_.width = 120;
         _loc3_.height = 25;
         addChild(_loc3_);
         _loc3_.setTextFormat(_loc2_);
         TweenMax.to(_loc3_,1,{
            "y":250,
            "onComplete":onShowAddIntergalComplete,
            "onCompleteParams":[_loc3_]
         });
      }
      
      private function onShowAddIntergalComplete(param1:TextField) : void
      {
         TweenMax.to(param1,1,{
            "y":100,
            "alpha":0,
            "onComplete":onMoveAddIntergalComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onMoveAddIntergalComplete(param1:TextField) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(e:Error)
         {
         }
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param1);
         GemMazeManager.Instance.sendDispatchEvent("GEMMAZE_UPDATE_BAG");
      }
      
      public function get model() : GemMazeModel
      {
         _model = GemMazeManager.Instance.model;
         return _model;
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _flagBitmap = ComponentFactory.Instance.creatBitmap("asset.GemMaze.Flag");
         _efMc = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeBoxViewEf");
         addChild(_efMc);
         _boxArr = [];
         _loc1_ = 1;
         while(_loc1_ < 6)
         {
            _boxArr[_loc1_ - 1] = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeIntergalBoxView");
            _boxArr[_loc1_ - 1].boxIndex = _loc1_;
            _boxArr[_loc1_ - 1].y = 325 - 80 * (_loc1_ - 1);
            _boxArr[_loc1_ - 1].filters = [UIFilter.getGrayFilter()];
            _boxArr[_loc1_ - 1].buttonMode = false;
            addChild(_boxArr[_loc1_ - 1]);
            _loc1_++;
         }
         addChild(_flagBitmap);
         initEvent();
         updateView();
      }
      
      public function updateView() : void
      {
         SORT_INDEX_ARRAY = model.scoreArr;
         updateEffMc();
         updateBox();
      }
      
      private function updateBox(param1:GemMazeEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(model.gemMazeInfo.score);
         _loc3_ = 0;
         while(_loc3_ < SORT_INDEX_ARRAY.length)
         {
            _boxArr[_loc3_].boxIndex = _loc3_ + 1;
            _boxArr[_loc3_].filters = [UIFilter.getGrayFilter()];
            _boxArr[_loc3_].removeCanGet();
            _boxArr[_loc3_].removeGetStatus();
            _boxArr[_loc3_].buttonMode = true;
            _boxArr[_loc3_].addEventListener("click",onBoxClick);
            if(_loc2_ >= SORT_INDEX_ARRAY[_loc3_])
            {
               _boxArr[_loc3_].filters = [];
               _boxArr[_loc3_].setCanGet();
               if(model.gemMazeInfo.boxMarkArr[_loc3_] == 1)
               {
                  _boxArr[_loc3_].setGetStatus();
                  _boxArr[_loc3_].buttonMode = false;
                  _boxArr[_loc3_].removeEventListener("click",onBoxClick);
               }
            }
            _loc3_++;
         }
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         clickBoxIndex = _boxArr.indexOf(param1.currentTarget);
         var _loc4_:Object = param1.currentTarget;
         var _loc2_:int = int(BOX_INDEX_ARR[clickBoxIndex]);
         var _loc5_:int = int(SORT_INDEX_ARRAY[clickBoxIndex]);
         if(_prizeView)
         {
            ObjectUtils.disposeObject(_prizeView);
         }
         _prizeView = new GemMazePrizeView(_loc5_);
         _prizeView.boxIndex = _loc2_;
         _prizeView.isCanGet = model.gemMazeInfo.score >= SORT_INDEX_ARRAY[clickBoxIndex];
         var _loc3_:Point = new Point(_loc4_.displayWidth / 2,0);
         _loc3_ = _loc4_.localToGlobal(_loc3_);
         _prizeView.x = _loc3_.x - _loc4_.displayWidth / 2 + 30;
         _prizeView.y = _loc3_.y - _loc4_.displayHeight - 5 + 60;
         LayerManager.Instance.addToLayer(_prizeView,7);
      }
      
      private function updateEffMc() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(model.gemMazeInfo.score);
         if(_loc1_ <= SORT_INDEX_ARRAY[0])
         {
            _loc2_ = _loc1_ / SORT_INDEX_ARRAY[0] * 40;
         }
         else if(SORT_INDEX_ARRAY[0] < _loc1_ && _loc1_ <= SORT_INDEX_ARRAY[1])
         {
            _loc2_ = 40 + (_loc1_ - SORT_INDEX_ARRAY[0]) / (SORT_INDEX_ARRAY[1] - SORT_INDEX_ARRAY[0]) * 75;
         }
         else if(SORT_INDEX_ARRAY[1] < _loc1_ && _loc1_ <= SORT_INDEX_ARRAY[2])
         {
            _loc2_ = 115 + (_loc1_ - SORT_INDEX_ARRAY[1]) / (SORT_INDEX_ARRAY[2] - SORT_INDEX_ARRAY[1]) * 80;
         }
         else if(SORT_INDEX_ARRAY[2] < _loc1_ && _loc1_ <= SORT_INDEX_ARRAY[3])
         {
            _loc2_ = 195 + (_loc1_ - SORT_INDEX_ARRAY[2]) / (SORT_INDEX_ARRAY[3] - SORT_INDEX_ARRAY[2]) * 80;
         }
         else if(SORT_INDEX_ARRAY[3] < _loc1_ && _loc1_ <= SORT_INDEX_ARRAY[4])
         {
            _loc2_ = 275 + (_loc1_ - SORT_INDEX_ARRAY[3]) / (SORT_INDEX_ARRAY[4] - SORT_INDEX_ARRAY[3]) * 75;
         }
         else
         {
            _loc2_ = 380;
         }
         maskTopPos = -_loc2_;
         _loc2_ = 592 - _loc2_;
         TweenMax.to(_efMc.mcEf,0.2,{"y":_loc2_});
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

