package gloryroad.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadMirrorInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PathManager;
   import yishi.view.tools.PetFormationMovieClip;
   
   public class GloryRoadPassNode extends Component
   {
      
      private var _roleContainer:Sprite;
      
      private var _heroMovie:PetFormationMovieClip;
      
      private var _light:Bitmap;
      
      private var _circle:Bitmap;
      
      private var _num:Bitmap;
      
      public var clickHanlder:Function;
      
      private var _isInit:Boolean = false;
      
      public function GloryRoadPassNode(param1:int)
      {
         super();
         initView(param1);
         initEvent();
      }
      
      private function initView(param1:int) : void
      {
         _roleContainer = new Sprite();
         _roleContainer.y = 25;
         _light = ComponentFactory.Instance.creatBitmap("asset.gloryroad.lightBg");
         _circle = ComponentFactory.Instance.creatBitmap("asset.gloryroad.circle");
         _num = new Bitmap(new (ClassUtils.getDefinition("asset.gloryroad.num" + param1))());
         _num.x = (_circle.width - _num.width) * 0.5;
         _num.y = 24;
         addChild(_roleContainer);
         addChild(_light);
         addChild(_circle);
         addChild(_num);
         this.buttonMode = true;
         this.tipStyle = "yishi.view.tips.GloryRoadRivalTip";
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(clickHanlder != null)
         {
            clickHanlder();
         }
      }
      
      private function heroMovieClipLoadComplete() : void
      {
         if(_heroMovie)
         {
            _heroMovie.x = 40;
            _heroMovie.y = 15;
            _heroMovie.mouseChildren = _heroMovie.mouseEnabled = false;
            _roleContainer.addChild(_heroMovie);
            _heroMovie.gotoAndPlay(1);
         }
      }
      
      public function updateHero() : void
      {
         var _loc1_:GloryRoadMirrorInfo = null;
         var _loc2_:ThaneInfo = null;
         var _loc3_:HeroRoleInfo = null;
         if(!_isInit)
         {
            _isInit = true;
            _loc1_ = GloryroadManager.instance.model.mirrorInfo;
            _loc2_ = new ThaneInfo();
            _loc2_.userId = _loc1_.userid;
            _loc2_.sexs = _loc1_.sexs;
            _loc2_.nickName = _loc1_.nickName;
            _loc2_.templateId = _loc1_.job;
            _loc2_.grades = _loc1_.grade;
            _loc2_.armsEquipAvata = _loc1_.arm;
            _loc2_.wingAvata = _loc1_.wing;
            _loc2_.bodyEquipAvata = _loc1_.cloth;
            _loc2_.armsFashionAvata = _loc1_.fashionArm;
            _loc2_.hairFashionAvata = _loc1_.hat;
            _loc2_.bodyFashionAvata = _loc1_.fashionCloth;
            _loc2_.hideFashion = _loc1_.hideFashion;
            _loc3_ = new HeroRoleInfo();
            _loc3_.heroInfo = _loc2_;
            _loc3_.heroInfo.dragonTalkerInfo.isDragonTalker = _loc1_.isDragonTalker;
            _loc3_.heroInfo.dragonTalkerInfo.battleBeastId = PathManager.isShowDragon(_loc2_) ? _loc1_.battleBeastId : 0;
            _heroMovie = new PetFormationMovieClip(_loc3_);
            _heroMovie.callBackComplete.addSingleListener(heroMovieClipLoadComplete);
            _heroMovie.startLoad();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_roleContainer);
         _roleContainer = null;
         ObjectUtils.disposeObject(_heroMovie);
         _heroMovie = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_circle);
         _circle = null;
         ObjectUtils.disposeObject(_num);
         _num = null;
         clickHanlder = null;
         super.dispose();
      }
   }
}

