package playerinfo.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.MountInfoMsg;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.SimpleMountInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.view.base.StarBar;
   
   public final class MountInfoView extends Frame
   {
      
      private var _bg:Sprite;
      
      private var _border:Scale9CornerImage;
      
      private var _name:FilterFrameText;
      
      private var _txt01:FilterFrameText;
      
      private var _txt02:FilterFrameText;
      
      private var _txt03:FilterFrameText;
      
      private var _txt04:FilterFrameText;
      
      private var _txt06:FilterFrameText;
      
      private var _bg01:ScaleLeftRightImage;
      
      private var _bg02:ScaleLeftRightImage;
      
      private var _bg03:ScaleLeftRightImage;
      
      private var _bg04:ScaleLeftRightImage;
      
      private var _bg06:ScaleLeftRightImage;
      
      private var _myInfoBorder:Scale9CornerImage;
      
      private var _myInfoBorder2:ScaleBitmapImage;
      
      private var _myInfoBg:MovieClip;
      
      private var _title2:FilterFrameText;
      
      private var _txt11:FilterFrameText;
      
      private var _txt12:FilterFrameText;
      
      private var _txt13:FilterFrameText;
      
      private var _txt14:FilterFrameText;
      
      private var _txt16:FilterFrameText;
      
      private var _bg11:ScaleLeftRightImage;
      
      private var _bg12:ScaleLeftRightImage;
      
      private var _bg13:ScaleLeftRightImage;
      
      private var _bg14:ScaleLeftRightImage;
      
      private var _bg16:ScaleLeftRightImage;
      
      private var _starBar:StarBar;
      
      private var _data:SimpleMountInfo;
      
      private var _mountMovieClip:MovieClip;
      
      public function MountInfoView()
      {
         super();
         initView();
         addEvent();
         requestSelfMountInfo();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("playerinfo.MountInfoBg");
         _border = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountInfoViewBorder");
         addToContent(_border);
         addToContent(_bg);
         _name = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountNameText");
         _starBar = new StarBar(5,0,"asset.wildsoul.EmptyStarBig","asset.wildsoul.FullStarBig");
         _starBar.x = 160;
         _starBar.y = 30;
         _starBar.visible = false;
         addToContent(_name);
         addToContent(_starBar);
         this.titleText = LanguageMgr.GetTranslation("mounts.command07");
         _txt01 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute01");
         _txt02 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute02");
         _txt03 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute03");
         _txt04 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute04");
         _txt06 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute06");
         _bg01 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg01");
         _bg02 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg02");
         _bg03 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg03");
         _bg04 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg04");
         _bg06 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg06");
         addToContent(_bg01);
         addToContent(_bg02);
         addToContent(_bg03);
         addToContent(_bg04);
         addToContent(_bg06);
         addToContent(_txt01);
         addToContent(_txt02);
         addToContent(_txt03);
         addToContent(_txt04);
         addToContent(_txt06);
         _myInfoBorder = ComponentFactory.Instance.creatComponentByStylename("playerinfo.myFrameBackImage");
         _myInfoBorder2 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.myMountInfoBg");
         _myInfoBg = ComponentFactory.Instance.creat("asset.playerinfo.MyMountInfoBg");
         _myInfoBg.x = 542;
         _myInfoBg.y = 8;
         _title2 = ComponentFactory.Instance.creatComponentByStylename("core.FrameTitleText");
         _txt11 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute01");
         _txt12 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute02");
         _txt13 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute03");
         _txt14 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute04");
         _txt16 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountAttribute06");
         _bg11 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg01");
         _bg12 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg02");
         _bg13 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg03");
         _bg14 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg04");
         _bg16 = ComponentFactory.Instance.creatComponentByStylename("playerinfo.AttributeBg06");
         _txt11.x = _txt12.x = _txt13.x = _txt14.x = _txt16.x = 622;
         _bg11.x = _bg12.x = _bg13.x = _bg14.x = _bg16.x = 622;
         if(ArmyManager.instance.thane.grades >= 40)
         {
            addToContent(_myInfoBorder);
            addToContent(_myInfoBorder2);
            addToContent(_myInfoBg);
            addToContent(_bg11);
            addToContent(_bg12);
            addToContent(_bg13);
            addToContent(_bg14);
            addToContent(_bg16);
            addToContent(_txt11);
            addToContent(_txt12);
            addToContent(_txt13);
            addToContent(_txt14);
            addToContent(_txt16);
            addToContent(_title2);
         }
         _title2.text = LanguageMgr.GetTranslation("MountInfoView.myMount");
         _title2.x = 600;
         _title2.y = -31;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResponse);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4459,__updateSelfMountInfoHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4459,__updateSelfMountInfoHandler);
      }
      
      private function __updateSelfMountInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4459,__updateSelfMountInfoHandler);
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountInfoMsg = new MountInfoMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as MountInfoMsg;
         var _loc4_:MountRefiningSoulInfo = new MountRefiningSoulInfo();
         _loc4_.strengthGrade = _loc2_.refiningSoulPowerGrade;
         _loc4_.intellectGrade = _loc2_.refiningSoulIntellectGrade;
         _loc4_.staminaGrade = _loc2_.refiningSoulPhysiqueGrade;
         _loc4_.armorGrade = _loc2_.refiningSoulAgilityGrade;
         var _loc3_:Array = [_loc2_.power,_loc2_.intellect,_loc2_.agility,_loc2_.physique];
         _loc7_ = 1;
         while(_loc7_ <= 4)
         {
            _loc11_ = Math.ceil(_loc3_[_loc7_ - 1] * _loc4_.getSkillAddPercent() / 100);
            _loc12_ = int(_loc4_.getPropAddPercentByPropName(PropertyInfo.PROP_NAME_ARR[_loc7_ - 1]));
            _loc10_ = int(ConfigInfoManager.instance.getMountRefiningSoulMaxValue());
            _loc8_ = Math.min(_loc11_,_loc10_);
            _loc5_ = Math.ceil(_loc8_ * _loc12_ / 100);
            _loc6_ = _loc3_[_loc7_ - 1] + _loc5_;
            this["_txt1" + _loc7_].text = _loc6_ + "";
            _loc7_++;
         }
         _txt16.text = String(_loc2_.powerGp);
      }
      
      private function requestSelfMountInfo() : void
      {
         var _loc1_:int = int(ArmyManager.instance.thane.userId);
         MountsManager.instance.mountOperateSend(5,0,0,_loc1_);
      }
      
      public function get data() : SimpleMountInfo
      {
         return _data;
      }
      
      public function set data(param1:SimpleMountInfo) : void
      {
         if(_mountMovieClip && _mountMovieClip.parent)
         {
            _mountMovieClip.stop();
            _mountMovieClip.parent.removeChild(_mountMovieClip);
            _mountMovieClip = null;
         }
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         _txt01.text = String(_data.power);
         _txt02.text = String(_data.intellect);
         _txt03.text = String(_data.physique);
         _txt04.text = String(_data.agility);
         _txt06.text = String(_data.powerGp);
         var _loc2_:MountTemplate = TempleteManager.instance.mountTemplateDic[_data.mountTempId];
         if(_loc2_)
         {
            _name.text = _loc2_.TemplateName;
            updateAvatar(_loc2_.AvatarPath);
         }
         _starBar.visible = param1.star > -1;
         _starBar.progress = param1.star;
         if(_loc2_)
         {
            _starBar.count = _loc2_.maxStarGrade;
         }
         if(_loc2_ && _loc2_.MountType == 4)
         {
            _starBar.visible = false;
         }
      }
      
      private function updateAvatar(param1:String) : void
      {
         var _loc2_:String = MountAvatarPathHelper.getUrl(param1);
         LoaderManagerII.instance.load(_loc2_,2,8,__onLoaded);
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc3_:Rectangle = null;
         if(isDie)
         {
            return;
         }
         if(_mountMovieClip)
         {
            _mountMovieClip.stop();
            _mountMovieClip.parent && _mountMovieClip.parent.removeChild(_mountMovieClip);
         }
         _mountMovieClip = param2 as MovieClip;
         if(_mountMovieClip)
         {
            _mountMovieClip.gotoAndStop(1);
            _loc4_ = new BitmapData(500,500,true,0);
            _loc4_.draw(_mountMovieClip);
            _loc3_ = _loc4_.getColorBoundsRect(4278190080,0,false);
            addToContent(_mountMovieClip);
            _mountMovieClip.x = int(4 + (290 - _loc3_.width) / 2) - _loc3_.x;
            if(_mountMovieClip["pos_down"])
            {
               _mountMovieClip.y = int(257 - _mountMovieClip["pos_down"].y - 15);
            }
            else
            {
               _mountMovieClip.y = int(42 + (215 - _loc3_.height) / 2) - _loc3_.y;
            }
            _mountMovieClip.gotoAndPlay(1);
            _loc4_.dispose();
            _loc4_ = null;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_mountMovieClip);
         _mountMovieClip = null;
         ObjectUtils.disposeObject(_txt01);
         ObjectUtils.disposeObject(_txt02);
         ObjectUtils.disposeObject(_txt03);
         ObjectUtils.disposeObject(_txt04);
         ObjectUtils.disposeObject(_txt06);
         ObjectUtils.disposeObject(_bg01);
         ObjectUtils.disposeObject(_bg02);
         ObjectUtils.disposeObject(_bg03);
         ObjectUtils.disposeObject(_bg04);
         ObjectUtils.disposeObject(_bg06);
         ObjectUtils.disposeObject(_txt11);
         ObjectUtils.disposeObject(_txt12);
         ObjectUtils.disposeObject(_txt13);
         ObjectUtils.disposeObject(_txt14);
         ObjectUtils.disposeObject(_txt16);
         ObjectUtils.disposeObject(_bg11);
         ObjectUtils.disposeObject(_bg12);
         ObjectUtils.disposeObject(_bg13);
         ObjectUtils.disposeObject(_bg14);
         ObjectUtils.disposeObject(_bg16);
         ObjectUtils.disposeObject(_myInfoBorder);
         ObjectUtils.disposeObject(_myInfoBorder2);
         ObjectUtils.disposeObject(_title2);
         ObjectUtils.disposeObject(_myInfoBg);
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         _txt01 = _txt02 = _txt03 = _txt04 = _txt06 = null;
         _bg01 = _bg02 = _bg03 = _bg04 = _bg06 = null;
         _txt11 = _txt12 = _txt13 = _txt14 = _txt16 = null;
         _bg11 = _bg12 = _bg13 = _bg14 = _bg16 = null;
         _myInfoBorder = null;
         _myInfoBorder2 = null;
         _title2 = null;
         _myInfoBg = null;
         super.dispose();
      }
   }
}

