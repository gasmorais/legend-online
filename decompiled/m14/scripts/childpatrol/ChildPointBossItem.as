package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.templates.ChildPveBossTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class ChildPointBossItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _wanted:Bitmap;
      
      private var _huawen:Bitmap;
      
      private var _bossNumberMc:MovieClip;
      
      private var _bossNumberBitmapData:BitmapData;
      
      private var _bossNameTxt:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      public function ChildPointBossItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.childpve.bossFrame");
         _wanted = ComponentFactory.Instance.creatBitmap("asset.childpve.wanted");
         _huawen = ComponentFactory.Instance.creatBitmap("asset.childpve.huawen");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("childPveBossItem.BossNameTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("childPveBossItem.headIcon");
         _bossNumberMc = ComponentFactory.Instance.creatCustomObject("childpve.BossNumber");
         _bossNumberBitmapData = ComponentFactory.Instance.creatBitmapData("asset.childpve.number").clone();
         addChild(_bg);
         addChild(_headIcon);
         addChild(_wanted);
         addChild(_huawen);
         addChild(_bossNumberMc);
         _bossNumberMc.x = 69;
         _bossNumberMc.y = 183;
         addChild(_bossNameTxt);
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChildPveBossTempInfo = TempleteManager.instance.childPveBossTemplateCate.getTemplateById(param1.bossId);
         if(_loc2_ != null)
         {
            NumberViewUtils.refreshValue(_loc2_.grade,_bossNumberMc["content"],_bossNumberBitmapData,13,20,10,13,"0123456789");
            _bossNameTxt.text = _loc2_.bossName;
            _headIcon.icon = IconFactory.getChildPveBossIconPath(_loc2_.icon);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_wanted);
         _wanted = null;
         ObjectUtils.disposeObject(_huawen);
         _huawen = null;
         ObjectUtils.disposeViolentMc(_bossNumberMc);
         _bossNumberMc = null;
         ObjectUtils.disposeObject(_bossNameTxt);
         _bossNameTxt = null;
         _bossNumberBitmapData = null;
         super.dispose();
      }
   }
}

