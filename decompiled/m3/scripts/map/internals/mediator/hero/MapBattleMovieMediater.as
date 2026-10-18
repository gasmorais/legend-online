package map.internals.mediator.hero
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import map.internals.view.hero.AvatarBaseView;
   import mvc.module.armyII.BaseArmy;
   import yishi.events.RoleEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class MapBattleMovieMediater implements IMediator
   {
      
      protected var target:AvatarBaseView;
      
      protected var data:BaseArmy;
      
      protected var queue:Vector.<MovieClip>;
      
      protected var pos:int;
      
      protected var numBitmapData2:BitmapData;
      
      protected var dieFilter:UIFilter;
      
      public function MapBattleMovieMediater()
      {
         super();
         numBitmapData2 = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1");
      }
      
      public function register(param1:Object) : void
      {
         target = param1 as AvatarBaseView;
         data = target["data"];
         queue = new Vector.<MovieClip>();
         pos = 0;
         if(data && data.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            data.addEventListener("battleStrategy",__strategyHandler);
            data.addEventListener("battleGP",__gpHandler);
            data.addEventListener("battleGold",__goldHandler);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(data && data.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            data.removeEventListener("battleStrategy",__strategyHandler);
            data.removeEventListener("battleGP",__gpHandler);
            data.removeEventListener("battleGold",__goldHandler);
         }
         for each(var _loc2_:MovieClip in queue)
         {
            _loc2_.stop();
            ObjectUtils.disposeViolentMc(_loc2_);
            _loc2_.parent && _loc2_.parent.removeChild(_loc2_);
         }
         ObjectUtils.disposeObject(numBitmapData2);
         numBitmapData2 = null;
         queue = null;
         dieFilter = null;
         param1 = null;
         data = null;
      }
      
      private function __strategyHandler(param1:RoleEvent) : void
      {
         playScoreMovie(int(param1.data),5);
      }
      
      private function __gpHandler(param1:RoleEvent) : void
      {
         playScoreMovie(int(param1.data),4);
      }
      
      private function __goldHandler(param1:RoleEvent) : void
      {
         playScoreMovie(int(param1.data),3);
      }
      
      protected function playScoreMovie(param1:int = -122, param2:int = 1) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:MovieClip = movieClip;
         target.addChild(_loc3_);
         var _loc4_:int = Math.abs(param1);
         NumberViewUtils.refreshValue(_loc4_,_loc3_["mv"]["pos"],numBitmapData2,19,25,15,19,"0123456789");
         if(!dieFilter)
         {
            dieFilter = new UIFilter();
         }
         if(param1 < 0)
         {
            dieFilter.setGrayFilter(_loc3_["mv"]["pos"]);
            _loc3_["mv"]["stateMc"].gotoAndStop(2);
         }
         else
         {
            dieFilter.setNormalFilter(_loc3_["mv"]["pos"]);
            _loc3_["mv"]["stateMc"].gotoAndStop(1);
         }
         _loc3_.mv.typeMc.gotoAndStop(param2);
         _loc3_.gotoAndPlay(2);
         _loc3_ = null;
      }
      
      private function get movieClip() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(queue.length < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("asset.campaign.pvp.UpdateScoreAsset");
            queue.push(_loc1_);
            return _loc1_;
         }
         if(pos == queue.length)
         {
            pos = 0;
         }
         return queue[pos++];
      }
   }
}

