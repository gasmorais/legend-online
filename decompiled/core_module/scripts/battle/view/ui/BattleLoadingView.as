package battle.view.ui
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import yishi.comm.PackageIn;
   import yishi.datas.BattleModel;
   import yishi.manager.PlayerManager;
   
   public class BattleLoadingView extends Component
   {
      
      private var _loadingMc:MovieClip;
      
      private var _callback:Function;
      
      public function BattleLoadingView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         if(ComponentSetting.isZhanQu)
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.zhanqu");
            _loadingMc["bg1"].gotoAndStop(2);
            _loadingMc["bg2"].gotoAndStop(2);
         }
         else if(ComponentSetting.is7road)
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.zhanqu");
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         else
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.shenqu");
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         addChild(_loadingMc);
      }
      
      public function startShowLoad(param1:Function) : void
      {
         _callback = param1;
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(!BattleManager.getInstance().resourceModel)
         {
            return;
         }
         if(BattleModel.battleUILoaded)
         {
            if(stage && _loadingMc)
            {
               _loadingMc.gotoAndStop(99);
            }
            _callback();
            return;
         }
         if(stage && _loadingMc)
         {
            _loadingMc.gotoAndStop(BattleManager.getInstance().resourceModel.progress());
         }
      }
      
      public function stopShowLoad() : void
      {
         removeEventListener("enterFrame",__enterFrame);
      }
      
      public function set pkg(param1:PackageIn) : void
      {
         PlayerManager.instance.currentPlayerModel.currntBattleId = param1.readInt().toString();
      }
      
      override public function dispose() : void
      {
         stopShowLoad();
         ObjectUtils.disposeViolentMc(_loadingMc);
         _loadingMc = null;
         _callback = null;
         super.dispose();
      }
   }
}

