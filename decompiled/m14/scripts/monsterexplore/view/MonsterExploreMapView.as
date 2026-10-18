package monsterexplore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.getTimer;
   import mvc.controler.MonsterExploreControler;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class MonsterExploreMapView extends Component implements IEnterFrame
   {
      
      private var _mapMask:Component;
      
      private var _mapCon:Component;
      
      private var _leftMap:BaseIconView;
      
      private var _rightMap:BaseIconView;
      
      private var mapPath:String;
      
      private var lastExecuteTime:Number = 0;
      
      private var lastFrameRunTime:Number = 0;
      
      private var moveDirtion:Number = 0;
      
      public function MonsterExploreMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreMapView.mapCon");
         _leftMap = ComponentFactory.Instance.creatCustomObject("MonsterExploreMapView.leftMapIcon",[loadLeftComplete]);
         _rightMap = ComponentFactory.Instance.creatCustomObject("MonsterExploreMapView.rightMapIcon",[loadRightComplete]);
         _mapMask = new Component();
         _mapMask.graphics.beginFill(16777215,1);
         _mapMask.graphics.drawRect(0,0,932,532);
         _mapMask.graphics.endFill();
         addChild(_mapCon);
         addChild(_mapMask);
         _mapCon.addChild(_leftMap);
         _mapCon.addChild(_rightMap);
         _mapCon.mask = _mapMask;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function loadLeftComplete(param1:BaseIconView = null) : void
      {
         if(_leftMap && _leftMap.content)
         {
            (_leftMap.content as Bitmap).smoothing = false;
         }
      }
      
      private function loadRightComplete(param1:BaseIconView = null) : void
      {
         if(_rightMap && _rightMap.content)
         {
            (_rightMap.content as Bitmap).smoothing = false;
         }
      }
      
      public function initMapView() : void
      {
         var _loc1_:MonsterExploreTempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.curChapterId,exploreModel.curNodeId);
         if(!_loc1_)
         {
            return;
         }
         mapPath = PathManager.getMonsterExploreMapPath(int(_loc1_.FightMapPath));
         _leftMap.icon = mapPath;
         _rightMap.icon = mapPath;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(exploreModel.exploreState == 1)
         {
            _loc2_ = getTimer();
            if(exploreModel.keepWalk && moveDirtion < 475 && lastExecuteTime > 0)
            {
               if(_leftMap.x <= -1864)
               {
                  _leftMap.x = 1863;
                  _rightMap.x = 0;
               }
               if(_rightMap.x < -1864)
               {
                  _leftMap.x = 0;
                  _rightMap.x = 1863;
               }
               _loc1_ = exploreModel.moveSpeed * (_loc2_ - lastFrameRunTime);
               moveDirtion += _loc1_;
               _leftMap.x -= _loc1_;
               _rightMap.x -= _loc1_;
               lastExecuteTime = getTimer();
            }
            lastFrameRunTime = getTimer();
            if(lastExecuteTime == 0)
            {
               lastExecuteTime = getTimer();
            }
         }
         else
         {
            moveDirtion = 0;
            lastExecuteTime = 0;
            lastFrameRunTime = 0;
         }
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      private function get control() : MonsterExploreControler
      {
         return FrameControllerManager.instance.monsterExploreController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftMap);
         _leftMap = null;
         ObjectUtils.disposeObject(_rightMap);
         _rightMap = null;
         ObjectUtils.disposeObject(_mapCon);
         _mapCon = null;
         ObjectUtils.disposeObject(_mapMask);
         _mapMask = null;
         super.dispose();
      }
   }
}

