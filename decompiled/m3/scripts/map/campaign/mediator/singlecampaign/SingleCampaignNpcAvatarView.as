package map.campaign.mediator.singlecampaign
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import map.campaign.CampaignManager;
   import mvc.controler.MonsterControler;
   import mvc.module.singlecampaign.SingleCampaignModel;
   import yishi.datas.templates.SingleCampaignDataTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.utils.StringHelper;
   
   public class SingleCampaignNpcAvatarView extends Component
   {
      
      private var _data:SingleCampaignDataTempInfo;
      
      private var _controller:MonsterControler;
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _npcName:FilterFrameText;
      
      private var swfPath:String;
      
      public function SingleCampaignNpcAvatarView()
      {
         super();
         initView();
         _controller = FrameControllerManager.instance.monsterController;
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignNpcNode.npcName");
      }
      
      public function get data() : SingleCampaignDataTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SingleCampaignDataTempInfo) : void
      {
         var _loc2_:Boolean = false;
         if(param1 && data && param1.ResPath == data.ResPath)
         {
            return;
         }
         _data = param1;
         var _loc3_:String = "";
         if(_data)
         {
            _npcName.text = data.NodeName;
            _npcName.x = -_npcName.textWidth / 2;
            _loc2_ = !StringHelper.isNullOrEmpty(data.Heros);
            if(singleModel.curIndex > data.Index)
            {
               _npcName.setFrame(1);
            }
            else
            {
               _loc2_ ? _npcName.setFrame(3) : _npcName.setFrame(2);
            }
            swfPath = PathManager.solveRolePath(data.ResPath);
            refresh();
         }
         else
         {
            clean();
         }
      }
      
      private function refresh() : void
      {
         clearBody();
         if(_controller.monsterDefineDic[swfPath])
         {
            createBody();
         }
         else
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyScale();
            LoaderManagerII.instance.load(swfPath,1,8,__loadedCompleteHandler);
         }
         if(_body)
         {
            addChild(_body);
         }
         addChild(_npcName);
         this.buttonMode = true;
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         clearBody();
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         var _loc5_:Class = _controller.monsterDefineDic[swfPath] as Class;
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
               _loc4_ = new LoaderContext(false,_loc3_);
               disposeLoader();
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("complete",__contentComplete);
               _loader.loadBytes(param2 as ByteArray,_loc4_);
            }
         }
         else
         {
            createBody();
         }
      }
      
      private function __contentComplete(param1:Event) : void
      {
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__contentComplete);
         var _loc3_:Class = _controller.monsterDefineDic[swfPath] as Class;
         if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + data.ResPath))
         {
            _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + data.ResPath) as Class;
            _controller.monsterDefineDic[swfPath] = _loc3_;
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function createBody() : void
      {
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         var _loc1_:Class = _controller.monsterDefineDic[swfPath] as Class;
         if(_loc1_)
         {
            _body = new _loc1_();
            setBodyScale(data.Scale / 100);
            addChild(_body);
            addChild(_npcName);
         }
      }
      
      public function setBodyScale(param1:Number = 1) : void
      {
         if(!_body)
         {
            return;
         }
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = param1;
      }
      
      public function getPosLeg() : Point
      {
         var _loc1_:MovieClip = null;
         if(_body && _body["pos_leg"])
         {
            _loc1_ = _body["pos_leg"] as MovieClip;
            return new Point(_loc1_.x,_loc1_.y);
         }
         return new Point(0,0);
      }
      
      private function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
         _npcName.text = "";
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__contentComplete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
      }
      
      private function get singleModel() : SingleCampaignModel
      {
         return CampaignManager.instance.singleCampaignModel;
      }
      
      override public function dispose() : void
      {
         disposeLoader();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
         ObjectUtils.disposeObject(_npcName);
         _npcName = null;
         super.dispose();
      }
   }
}

