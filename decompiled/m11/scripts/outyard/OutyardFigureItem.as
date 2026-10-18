package outyard
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import map.campaign.data.OutyardAttackInfo;
   
   public class OutyardFigureItem extends Component
   {
      
      private var _figureNum:MovieClip;
      
      private var _figureMc:MovieClip;
      
      private var _num:FilterFrameText;
      
      private var _count:int;
      
      private var _fromPoint:Point;
      
      private var _toPoint:Point;
      
      private var _info:OutyardAttackInfo;
      
      private var _parent:OutyardFigureView;
      
      public function OutyardFigureItem(param1:Point, param2:Point, param3:OutyardAttackInfo, param4:OutyardFigureView)
      {
         super();
         _fromPoint = param1;
         _toPoint = param2;
         _info = param3;
         _parent = param4;
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _figureNum = ComponentFactory.Instance.creatCustomObject("outyard.figureNum");
         _figureMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.figure_" + _info.key);
         _num = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFigureItem.playerNumTxt");
         addChild(_figureNum);
         addChild(_figureMc);
         addChild(_num);
         this.x = _toPoint.x;
         this.y = _toPoint.y;
         _count = _info.totalCount;
      }
      
      public function changeCount(param1:int, param2:int) : void
      {
         _count = param2;
         if(param1 < 0)
         {
            refreshView();
         }
         else
         {
            showAddIntergal();
         }
      }
      
      private function showAddIntergal() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.outyard.figure_" + _info.key);
         _loc1_.x = _fromPoint.x;
         _loc1_.y = _fromPoint.y;
         _parent.addChild(_loc1_);
         TweenMax.to(_loc1_,1,{
            "x":_toPoint.x,
            "y":_toPoint.y,
            "onComplete":onShowAddComplete,
            "onCompleteParams":[_loc1_]
         });
      }
      
      private function onShowAddComplete(param1:MovieClip) : void
      {
         try
         {
            TweenMax.killChildTweensOf(param1);
            ObjectUtils.disposeViolentMc(param1);
            refreshView();
         }
         catch(e:Error)
         {
         }
      }
      
      private function refreshView() : void
      {
         _num.text = "" + _count;
         _figureMc.visible = _count > 0;
         _figureNum.visible = _count > 0;
         _num.visible = _count > 0;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_figureNum);
         _figureNum = null;
         ObjectUtils.disposeViolentMc(_figureMc);
         _figureMc = null;
         ObjectUtils.disposeObject(_num);
         _num = null;
         _info = null;
         _parent = null;
         super.dispose();
      }
   }
}

