package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.events.MouseEvent;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   import mvc.module.remotepet.RemotePetTurnItemInfo;
   import yishi.manager.FrameControllerManager;
   
   public class RemotePetTurnUpView extends Component
   {
      
      private var _lineImg:ScaleFrameImage;
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _turnList:Vector.<RemotePetTurnInfoItemView>;
      
      private var pos:Array = [{
         "x":60,
         "y":100
      },{
         "x":163,
         "y":63
      },{
         "x":261,
         "y":110
      },{
         "x":218,
         "y":192
      },{
         "x":200,
         "y":125
      },{
         "x":160,
         "y":285
      },{
         "x":290,
         "y":309
      },{
         "x":387,
         "y":228
      },{
         "x":380,
         "y":148
      },{
         "x":485,
         "y":110
      },{
         "x":385,
         "y":95
      },{
         "x":510,
         "y":215
      },{
         "x":537,
         "y":312
      },{
         "x":623,
         "y":310
      },{
         "x":697,
         "y":287
      },{
         "x":738,
         "y":183
      },{
         "x":733,
         "y":320
      },{
         "x":788,
         "y":95
      }];
      
      private var pos2:Array = [{
         "x":113,
         "y":83
      },{
         "x":213,
         "y":152
      },{
         "x":160,
         "y":273
      },{
         "x":275,
         "y":327
      },{
         "x":112,
         "y":301
      },{
         "x":377,
         "y":260
      },{
         "x":493,
         "y":293
      },{
         "x":592,
         "y":223
      },{
         "x":580,
         "y":122
      },{
         "x":708,
         "y":143
      },{
         "x":525,
         "y":90
      },{
         "x":770,
         "y":260
      }];
      
      public function RemotePetTurnUpView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemotePetTurnInfoItemView = null;
         _turnList = new Vector.<RemotePetTurnInfoItemView>();
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnUpView.lineImg");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnUpView.lastBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnUpView.nextBtn");
         addChild(_lineImg);
         _lineImg.setFrame(1);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetTurnInfoItemView");
            _turnList.push(_loc1_);
            _loc2_++;
         }
         __listHandler(null);
      }
      
      private function __listHandler(param1:RemotePetEvent) : void
      {
         if(model.turnInfo.currPage >= 7)
         {
            _lineImg.setFrame(2);
         }
         else
         {
            _lineImg.setFrame(1);
         }
         _lastPageBtn.enable = model.turnInfo.currPage != 1;
         _nextPageBtn.enable = model.turnInfo.currPage != model.turnInfo.totalPage;
         if(!model.turnInfo.showTurnList)
         {
            return;
         }
         for each(var _loc2_:RemotePetTurnInfoItemView in _turnList)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         var _loc4_:int = 0;
         for each(var _loc3_:RemotePetTurnItemInfo in model.turnInfo.showTurnList)
         {
            if(model.turnInfo.currPage >= 7)
            {
               _turnList[_loc4_].x = pos2[_loc4_].x;
               _turnList[_loc4_].y = pos2[_loc4_].y;
            }
            else
            {
               _turnList[_loc4_].x = pos[_loc4_].x;
               _turnList[_loc4_].y = pos[_loc4_].y;
            }
            _turnList[_loc4_].data = _loc3_;
            addChild(_turnList[_loc4_]);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         model.addEventListener("Turn_LIST",__listHandler);
      }
      
      private function removeEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         model.removeEventListener("Turn_LIST",__listHandler);
      }
      
      private function uninitView() : void
      {
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         for each(_loc1_ in _turnList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.remotePetController.pageLookHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

