package vehicle.daimon.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.vehicle.DaimonModel;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DaimonLeftView extends Component
   {
      
      private var _bgBorder:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _speedTxt:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _bg:MovieClip;
      
      private var _nameMask:Bitmap;
      
      private var _icon01:BaseIconView;
      
      private var _icon02:BaseIconView;
      
      private var _model:DaimonModel = FrameControllerManager.instance.vehicleDaimonController.model;
      
      private var _vehicleTempid:int;
      
      private var _vehiclemc:Bitmap;
      
      private var _contentSprite:Sprite;
      
      public function DaimonLeftView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bgBorder = ComponentFactory.Instance.creatComponentByStylename("DaimonLeftView.BgBorder2");
         _bg = ComponentFactory.Instance.creat("asset.daimon.DaimonBg");
         _nameMask = ComponentFactory.Instance.creat("asset.daimon.NameBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.NameTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt2");
         _speedTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt2");
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt2");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt2");
         _icon01 = ComponentFactory.Instance.creatCustomObject("DaimonLeftView.SkillItemView");
         _icon02 = ComponentFactory.Instance.creatCustomObject("DaimonLeftView.SkillItemView");
         _icon02.x += 50;
         _contentSprite = new Sprite();
         _contentSprite.x = 145;
         _contentSprite.y = 227;
         _hpTxt.x = 56;
         _hpTxt.y = 270;
         _attackTxt.x = 73;
         _attackTxt.y = 293;
         _defenceTxt.x = 73;
         _defenceTxt.y = 316;
         _speedTxt.x = 223;
         _speedTxt.y = 270;
         addChild(_bgBorder);
         addChild(_bg);
         addChild(_contentSprite);
         addChild(_nameMask);
         addChild(_nameTxt);
         addChild(_attackTxt);
         addChild(_speedTxt);
         addChild(_defenceTxt);
         addChild(_hpTxt);
         addChild(_icon01);
         addChild(_icon02);
      }
      
      private function unitView() : void
      {
         if(_vehiclemc)
         {
            _vehiclemc.bitmapData.dispose();
            _vehiclemc = null;
         }
         _bg = null;
         _bgBorder = null;
         _contentSprite = null;
      }
      
      public function update() : void
      {
         var _loc1_:VehicleSkillTempInfo = null;
         var _loc4_:String = null;
         if(_model.currentVehicleTempid == _vehicleTempid)
         {
            return;
         }
         _vehicleTempid = _model.currentVehicleTempid;
         var _loc3_:TempleteManager = TempleteManager.instance;
         var _loc2_:VehicleObjectTempInfo = _loc3_.vehicleObjectTempInfoCate.getTemplateByIndex(_vehicleTempid);
         if(_loc2_)
         {
            _nameTxt.text = _loc2_.TemplateName;
            _attackTxt.text = "" + _loc2_.Attack;
            _speedTxt.text = "" + _loc2_.Speed.toString();
            _defenceTxt.text = "" + String(_loc2_.Defence);
            _hpTxt.text = "" + String(_loc2_.Hp);
            _loc1_ = _loc3_.vehicleSkillTempteCate.getTemplateByTid(_loc2_.GeniusSkill);
            if(_loc1_)
            {
               _icon01.icon = IconFactory.getCommonIconPath(_loc1_.Icons);
               _icon01.tipData = _loc1_;
            }
            _loc4_ = PathManager.getVehicleShowAvatarPath(_loc2_.Avatar);
            if(_loc4_ == "")
            {
               return;
            }
            LoaderManagerII.instance.load(_loc4_,2,8,__onCompleteHandler);
         }
      }
      
      private function __onCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_contentSprite);
         if(_vehiclemc && _vehiclemc.bitmapData)
         {
            _vehiclemc.bitmapData.dispose();
         }
         _vehiclemc = param2 as Bitmap;
         if(_vehiclemc)
         {
            _contentSprite.addChild(_vehiclemc);
            _vehiclemc.x = -(_vehiclemc.width >> 1);
            _vehiclemc.y = -(_vehiclemc.height - 35);
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onCompleteHandler);
         unitView();
         _model = null;
         super.dispose();
      }
   }
}

