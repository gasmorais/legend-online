package monopoly.gemmaze.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.GemMazeEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import gemmaze.view.GemMazeGemCell;
   import manager.LanguageMgr;
   import managers.MonopolyGemMazeManager;
   import mvc.module.gemmaze.GemMazeModel;
   import mvc.module.gemmaze.info.GemInfoUpdateInfoVO;
   import mvc.module.gemmaze.info.GemMazeGemInfoVO;
   import mvc.module.stararea.StarareaManager;
   import yishi.manager.GoodsManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyGemMazeView extends Sprite implements Disposeable
   {
      
      private static const beginX:int = 20;
      
      private static const beginY:int = 15;
      
      private static const offsetX:int = 5;
      
      private static const offsetY:int = 3;
      
      private static const Gem_Width:int = 60;
      
      private static const Gem_Height:int = 60;
      
      private var _model:GemMazeModel;
      
      private var _gemCellArr:Array = [];
      
      private var _currentGemCell:GemMazeGemCell;
      
      private var gemInfoUpdateInfoVO:GemInfoUpdateInfoVO;
      
      private var _isAction:Boolean = false;
      
      private var _indexBegin:int;
      
      private var _indexEnd:int;
      
      public function MonopolyGemMazeView()
      {
         super();
         _model = MonopolyGemMazeManager.Instance.model;
         initView();
      }
      
      private function initView() : void
      {
         this.scrollRect = new Rectangle(0,0,361,347);
         updateView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_UPDATE_INFO",onUpdateGemInfo);
         MonopolyGemMazeManager.Instance.addEventListener("GEMMAZE_GEM_PLAYER_GOODS_FLY",onGoodsFly);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _gemCellArr.length)
         {
            _gemCellArr[_loc1_].removeEventListener("click",onCellClick);
            _loc1_++;
         }
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_GET_INIT_INFO",onGetInitInfo);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_UPDATE_INFO",onUpdateGemInfo);
         MonopolyGemMazeManager.Instance.removeEventListener("GEMMAZE_GEM_PLAYER_GOODS_FLY",onGoodsFly);
      }
      
      private function onGoodsFly(param1:GemMazeEvent) : void
      {
         createIconAnime(param1.data);
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
         icon.x = this.localToGlobal(new Point(160,-70)).x;
         icon.y = this.localToGlobal(new Point(160,-70)).y;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagPoint = this.localToGlobal(new Point(450,150));
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
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param1);
         MonopolyGemMazeManager.Instance.sendDispatchEvent("GEMMAZE_UPDATE_BAG");
      }
      
      private function onUpdateGemInfo(param1:GemMazeEvent) : void
      {
         if(_isAction)
         {
            return;
         }
         updateGemInfo();
      }
      
      private function updateGemInfo() : void
      {
         gemInfoUpdateInfoVO = _model.updateSignUpdateData();
         _isAction = true;
         updateRemoveData();
      }
      
      private function updateRemoveData() : void
      {
         var _loc3_:int = 0;
         var _loc4_:GemMazeGemCell = null;
         var _loc1_:GemMazeGemInfoVO = null;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < gemInfoUpdateInfoVO.gemDelArr.length)
         {
            _loc1_ = gemInfoUpdateInfoVO.gemDelArr[_loc3_];
            _loc4_ = getGemCellByIndex(_loc1_.index);
            if(_loc4_ != null)
            {
               _loc4_.gemInfo.nextIndex = -1;
               _loc4_.gemInfo.isRemove = true;
               _loc4_.removeSelf();
               _loc4_.removeEventListener("click",onCellClick);
               delGemCellByIndex(_loc1_.index);
               _loc2_.push({
                  "index":_loc1_.index,
                  "x":_loc4_.x,
                  "y":_loc4_.y
               });
            }
            _loc3_++;
         }
         _loc4_.addEventListener("GEMMAZE_REMOVE_COMPLETE",updateAddAndNew);
         MonopolyGemMazeManager.Instance.sendDispatchEvent("GEMMAZE_PLAYER_GRAIN",_loc2_);
         MonopolyGemMazeManager.Instance.sendDispatchEvent("GEMMAZE_GEM_UPDATE_FRAME");
      }
      
      private function updateAddAndNew(param1:GemMazeEvent = null) : void
      {
         var _loc2_:int = 0;
         MonopolyGemMazeManager.Instance.sendDispatchEvent("GEMMAZE_ADD_INTERGAL",gemInfoUpdateInfoVO.addIntergal);
         _loc2_ = 0;
         while(_loc2_ < gemInfoUpdateInfoVO.rewardInfo.rewardIdArr.length)
         {
            setTimeout(createIconAnime,200 * _loc2_,gemInfoUpdateInfoVO.rewardInfo.rewardIdArr[_loc2_].rewardId);
            _loc2_++;
         }
         if(param1 != null)
         {
            param1.currentTarget.removeEventListener("GEMMAZE_REMOVE_COMPLETE",updateAddAndNew);
         }
         updateMoveData();
         updateAddData();
         updateAllGem();
      }
      
      private function updateMoveData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GemMazeGemCell = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _gemCellArr.length)
         {
            _loc3_ = _gemCellArr[_loc2_];
            if(_loc3_.gemInfo.nextIndex != -1)
            {
               _loc1_ = getDownCount(_loc3_.gemInfo.index);
               _loc3_.gemInfo.nextIndex = _loc3_.gemInfo.index + _loc1_ * 5;
               if(_loc1_ > 0)
               {
                  _loc3_.gemInfo.isMove = true;
               }
            }
            _loc2_++;
         }
      }
      
      private function updateAddData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GemMazeGemInfoVO = null;
         var _loc4_:GemMazeGemCell = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _model.gemMazeInfo.gemArr.length)
         {
            _loc1_ = _model.gemMazeInfo.gemArr[_loc2_];
            if(_loc1_.isRemove && _loc1_.nextIndex == -1)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeGemCell");
               _loc1_.type = gemInfoUpdateInfoVO.gemAddArr[_loc3_].type;
               _loc1_.nextIndex = gemInfoUpdateInfoVO.gemAddArr[_loc3_].index;
               _loc1_.isAdd = true;
               _loc4_.gemInfo = _loc1_;
               _loc4_.x = getXByIndex(_loc1_.nextIndex);
               _loc4_.y = -65;
               addChild(_loc4_);
               _loc4_.addEventListener("click",onCellClick);
               _gemCellArr.push(_loc4_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function updateAllGem() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GemMazeGemCell = null;
         var _loc1_:GemMazeGemCell = null;
         var _loc6_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _gemCellArr.length)
         {
            _loc5_ = _gemCellArr[_loc2_];
            if(_loc5_.gemInfo.isMove || Boolean(_loc5_.gemInfo.isAdd))
            {
               _loc6_ = int(_loc5_.gemInfo.nextIndex);
               _loc3_ = getXByIndex(_loc6_);
               _loc4_ = getYByIndex(_loc6_);
               _loc5_.action(_loc3_,_loc4_);
               _loc5_.gemInfo.index = _loc5_.gemInfo.nextIndex;
               _loc1_ = _loc5_;
            }
            _loc2_++;
         }
         _model.setAllGemStatus();
         if(_model.gemUpdateArr.length != 0 && _loc1_ != null)
         {
            _loc1_.addEventListener("GEMMAZE_GEM_ACTION_COMPLETE",onAllMoveComplete);
         }
         else
         {
            _isAction = false;
         }
      }
      
      private function onAllMoveComplete(param1:GemMazeEvent) : void
      {
         param1.currentTarget.removeEventListener("GEMMAZE_GEM_ACTION_COMPLETE",onAllMoveComplete);
         updateGemInfo();
      }
      
      private function getDownCount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:GemMazeGemInfoVO = null;
         while(param1 + 5 < 25)
         {
            param1 += 5;
            _loc2_ = _model.gemMazeInfo.getGemMazeGemInfoVOByIndex(param1);
            if(_loc2_ == null)
            {
               return 0;
            }
            if(_loc2_.nextIndex == -1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function getAddCountByIndex(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = param1 + 5;
         while(_loc3_ < 25)
         {
            _loc4_ = 0;
            while(_loc4_ < gemInfoUpdateInfoVO.gemAddArr.length)
            {
               if(gemInfoUpdateInfoVO.gemAddArr[_loc4_].index == _loc3_)
               {
                  _loc2_ += 1;
               }
               _loc4_++;
            }
            _loc3_ += 5;
         }
         return _loc2_;
      }
      
      private function onGetInitInfo(param1:GemMazeEvent) : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GemMazeGemCell = null;
         if(_model.gemMazeInfo.gemArr.length == 0)
         {
            return;
         }
         if(_gemCellArr.length == 0)
         {
            _gemCellArr = [];
            _loc1_ = 0;
            while(_loc1_ < _model.gemMazeInfo.gemArr.length)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("GemMaze.GemMazeGemCell");
               _loc2_.gemInfo = _model.gemMazeInfo.gemArr[_loc1_];
               addChild(_loc2_);
               _loc2_.x = getXByIndex(_loc2_.gemInfo.index);
               _loc2_.y = getYByIndex(_loc2_.gemInfo.index);
               _loc2_.addEventListener("click",onCellClick);
               _gemCellArr.push(_loc2_);
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < _gemCellArr.legth)
            {
               _loc2_ = _gemCellArr[_loc1_];
               addChild(_loc2_);
               _loc2_.addEventListener("click",onCellClick);
               _loc1_++;
            }
         }
      }
      
      private function onCellClick(param1:MouseEvent) : void
      {
         if(!_model.canMoveGemByUser)
         {
            return;
         }
         if(_isAction)
         {
            return;
         }
         if(_model.gemMazeInfo.timesLeft <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gemMaze.GemMazeView.TipsTxt"));
            return;
         }
         setCurrentCell(param1.currentTarget as GemMazeGemCell);
      }
      
      private function setCurrentCell(param1:GemMazeGemCell) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(_currentGemCell == null)
         {
            _currentGemCell = param1;
            param1.selected = true;
            return;
         }
         if(_currentGemCell == param1)
         {
            _currentGemCell.selected = false;
            _currentGemCell = null;
            return;
         }
         if(!isUpon(_currentGemCell,param1))
         {
            _currentGemCell.selected = false;
            _currentGemCell = param1;
            _currentGemCell.selected = true;
         }
         else
         {
            _loc4_ = int(GoodsManager.instance.getMazeBagList().getList().length);
            if(_loc4_ >= 48)
            {
               _loc2_ = LanguageMgr.GetTranslation("gemMaze.gemMazeView.BagFullTips");
               MessageTipManager.instance().show(_loc2_);
               removeSelected();
               return;
            }
            _model.canMoveGemByUser = true;
            _indexBegin = _currentGemCell.gemInfo.index;
            _indexEnd = param1.gemInfo.index;
            _loc3_ = int(_currentGemCell.gemInfo.index);
            _currentGemCell.gemInfo.index = param1.gemInfo.index;
            param1.gemInfo.index = _loc3_;
            param1.action(_currentGemCell.x,_currentGemCell.y);
            _currentGemCell.action(param1.x,param1.y);
            _currentGemCell.addEventListener("GEMMAZE_GEM_ACTION_COMPLETE",onReplacePosComplete);
            _currentGemCell.selected = param1.selected = false;
            _currentGemCell = null;
         }
      }
      
      public function removeSelected() : void
      {
         if(_currentGemCell != null)
         {
            _currentGemCell.selected = false;
         }
         _currentGemCell = null;
      }
      
      private function onReplacePosComplete(param1:GemMazeEvent) : void
      {
         param1.currentTarget.removeEventListener("GEMMAZE_GEM_ACTION_COMPLETE",onReplacePosComplete);
         if(StarareaManager.instance.isStarareaGame)
         {
            StarareaManager.instance.sendPlayGame(2,1,_indexBegin + "," + _indexEnd);
         }
         else
         {
            MonopolyGemMazeManager.Instance.moveGem(_indexBegin,_indexEnd);
         }
      }
      
      private function isUpon(param1:GemMazeGemCell, param2:GemMazeGemCell) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1.gemInfo.index == param2.gemInfo.index + 1)
         {
            _loc3_ = true;
         }
         if(param1.gemInfo.index == param2.gemInfo.index - 1)
         {
            _loc3_ = true;
         }
         if(param1.gemInfo.index == param2.gemInfo.index + 5)
         {
            _loc3_ = true;
         }
         if(param1.gemInfo.index == param2.gemInfo.index - 5)
         {
            _loc3_ = true;
         }
         if(param1.gemInfo.index % 5 == 0 && param2.gemInfo.index == param1.gemInfo.index - 1)
         {
            _loc3_ = false;
         }
         if(param2.gemInfo.index % 5 == 0 && param2.gemInfo.index == param1.gemInfo.index + 1)
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function delGemCellByIndex(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _gemCellArr.length)
         {
            if(_gemCellArr[_loc2_].gemInfo.index == param1)
            {
               _gemCellArr.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function getGemCellByIndex(param1:int) : GemMazeGemCell
      {
         var _loc3_:GemMazeGemCell = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _gemCellArr.length)
         {
            if(_gemCellArr[_loc2_].gemInfo.index == param1)
            {
               _loc3_ = _gemCellArr[_loc2_];
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function delGemCellByIndexArArr(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GemMazeGemCell = null;
         _loc2_ = 0;
         while(_loc2_ < _gemCellArr.length)
         {
            _loc3_ = _gemCellArr[_loc2_];
            if(_loc3_.gemInfo.index == param1)
            {
               _gemCellArr.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function getXByIndex(param1:int) : int
      {
         return int(20 + (60 + 5) * (param1 % 5));
      }
      
      private function getYByIndex(param1:int) : int
      {
         return int(15 + (60 + 3) * (int(param1 / 5)));
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

