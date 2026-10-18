package sort
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import managers.ChildManager;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import yishi.datas.consant.JobType;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class SortMemberItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _levelIcon:Bitmap;
      
      private var _model:SortModel;
      
      private var _para1:FilterFrameText;
      
      private var _para2:FilterFrameText;
      
      private var _vipnameTxt:GradientText;
      
      private var _para3:FilterFrameText;
      
      private var _para4:FilterFrameText;
      
      private var _para5:FilterFrameText;
      
      private var _para6:FilterFrameText;
      
      private var _serverName:FilterFrameText;
      
      private var _petName:FilterFrameText;
      
      private var _levleHbox:HBox;
      
      private var _index:int;
      
      private var _data:SortData;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:PlayerMenu;
      
      public function SortMemberItem(param1:SortModel)
      {
         super();
         _model = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.itemBg");
         _levelIcon = ComponentFactory.Instance.creatBitmap("asset.sort.LevelImg");
         _para1 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle1");
         _para2 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle2");
         _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle2_vip");
         _para3 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle3");
         _para4 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle4");
         _para5 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle5");
         _para6 = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle6");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("sort.ItemTextStyle2");
         _petName = ComponentFactory.Instance.creatComponentByStylename("sort.PetNameTxt");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("sort.VocationIcon");
         _levleHbox = new HBox();
         _levleHbox.x = 333;
         _levleHbox.addChild(_levelIcon);
         _levelIcon.visible = false;
         _levleHbox.addChild(_para3);
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_para1);
         addChild(_levleHbox);
         addChild(_para4);
         addChild(_para5);
         addChild(_para6);
         addChild(_serverName);
         addChild(_petName);
         addChild(_vocationIcon);
         _serverName.text = "37wan001";
         _serverName.visible = false;
         _vocationIcon.visible = false;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeAllChildren(_levleHbox);
         ObjectUtils.disposeAllChildren(this);
         _levleHbox = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onMouseOver);
         addEventListener("rollOut",__onMouseOut);
         addEventListener("click",__onClickHandler);
      }
      
      private function remveEvent() : void
      {
         removeEventListener("rollOver",__onMouseOver);
         removeEventListener("rollOut",__onMouseOut);
         removeEventListener("click",__onClickHandler);
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_data)
         {
            _bg.setFrame(2);
         }
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         if(_model.currentSelected == 1 || _model.currentSelected == 2 || _model.currentSelected == 5 || _model.currentSelected == 3 || _model.currentSelected == 6 || _model.currentSelected == 7 || _model.currentSelected == 14)
         {
            _loc3_ = false;
            if(_model.isCross)
            {
               _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.serviceName;
               _loc3_ = _loc2_ != _data.serverName;
            }
            _menu = new PlayerMenu(false,false,_loc3_);
            _menu.setData(_data);
            _menu.x = StageReferance.stage.mouseX;
            _menu.y = StageReferance.stage.mouseY;
            LayerManager.Instance.addToLayer(_menu,7);
         }
         else if(_model.currentSelected == 9)
         {
            FrameControllerManager.instance.openControllerByInfo("pet","LOOKUP_FRAME",_data.petData);
         }
         else if(_model.currentSelected == 13)
         {
            PlayerManager.instance.lookingPlayerName = _data.nikcName;
            FrameControllerManager.instance.openControllerByInfo("child","look_information",_data.childData);
         }
      }
      
      public function dispose() : void
      {
         remveEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get para1() : FilterFrameText
      {
         return _para1;
      }
      
      public function set para1(param1:FilterFrameText) : void
      {
         _para1 = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get data() : SortData
      {
         return _data;
      }
      
      public function set data(param1:SortData) : void
      {
         _data = param1;
         if(_model.isCross)
         {
            refreshCrossView();
         }
         else
         {
            refreshView();
         }
      }
      
      private function refreshVocation() : void
      {
         if(_model.isCross)
         {
            _vocationIcon.x = 245;
         }
         else
         {
            _vocationIcon.x = 310;
         }
         if(_model.currentSelected == 1 && _data && _data.army && _data.army.baseHero && _data.army.baseHero.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.army.baseHero.templateInfo.Job,_data.army.baseHero.vocationStep,_data.army.baseHero.vocationLevel);
            _vocationIcon.setFrame(_data.army.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function refreshCrossView() : void
      {
         var _loc1_:TextFormat = null;
         var _loc2_:int = 0;
         refreshVocation();
         if(_data)
         {
            _serverName.visible = true;
            _levleHbox.x = 269;
            _para2.x = 64;
            _para1.text = _data.orderId.toString();
            _serverName.text = _data.serverName;
            _petName.text = "";
            _vipIcon.x = 70;
            switch(int(_model.currentSelected) - 1)
            {
               case 0:
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 180;
                  _para4.x = 415;
                  _para4.width = 130;
                  _serverName.x = 303;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para3.text = _data.grades.toString();
                  _para4.text = _data.gp.toString();
                  break;
               case 1:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 208;
                  _para4.x = 405;
                  _serverName.x = 270;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.fightCapacity.toString();
                  break;
               case 2:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 208;
                  _para4.x = 405;
                  _serverName.x = 270;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.multipleCapacity.toString();
                  break;
               case 3:
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _para5.visible = false;
                  _para6.visible = false;
                  _para4.x = 419;
                  _levleHbox.x = 213;
                  _serverName.x = 274;
                  _para2.text = _data.consortiaName;
                  _para3.text = _data.consortiaLevel.toString();
                  _para4.text = _data.consortiaFightPower.toString();
                  break;
               case 4:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = true;
                  _para5.x = 180;
                  _para4.x = 226;
                  _para4.width = 130;
                  _serverName.x = 303;
                  _para6.x = 430;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _model.getHonourName(_data.selfHonour);
                  _para6.text = _data.selfHonour.toString();
                  break;
               case 5:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 208;
                  _para4.x = 405;
                  _serverName.x = 270;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.charms.toString();
                  break;
               case 6:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 208;
                  _para4.x = 405;
                  _serverName.x = 270;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.soulScore.toString();
                  break;
               case 8:
                  _para5.visible = true;
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _petName.text = _data.petData.name;
                  _petName.setFrame(_data.petData.quality);
                  _para5.text = _data.petData.petTypeLanguage;
                  _para2.text = _data.nikcName;
                  _para3.text = _data.petData.grade + "";
                  _para4.text = _data.petData.fightPower + "";
                  _serverName.text = _data.serverName;
                  _loc1_ = _petName.getTextFormat();
                  _loc1_.align = "center";
                  _petName.setTextFormat(_loc1_);
                  _petName.x = 65;
                  _para2.x = 199;
                  _para5.x = 154;
                  _levleHbox.x = 330;
                  _para4.x = 458;
                  _vipIcon.x = 212;
                  _serverName.x = 355;
                  break;
               case 12:
                  _para5.visible = false;
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _levelIcon.visible = false;
                  _petName.text = _data.childData.name;
                  _petName.setFrame(7);
                  _para2.text = _data.nikcName;
                  _para3.text = ChildManager.instance.getJobName(_data.childData.job);
                  _para4.text = _data.childData.fightValue + "";
                  _serverName.text = _data.serverName;
                  _loc1_ = _petName.getTextFormat();
                  _loc1_.align = "center";
                  _petName.setTextFormat(_loc1_);
                  _petName.x = 75;
                  _para2.x = 157;
                  _levleHbox.x = 290;
                  _para4.x = 458;
                  _vipIcon.x = 212;
                  _serverName.x = 345;
                  break;
               case 13:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 208;
                  _para4.x = 405;
                  _serverName.x = 270;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = "" + _data.army.baseHero.theseusInfo.propertys.armour;
            }
            _vipnameTxt.x = _para2.x;
            _vipnameTxt.y = _para2.y;
            _vipnameTxt.text = _para2.text;
            _vipIcon.y = _vipnameTxt.y + 2;
            _para2.parent && _para2.parent.removeChild(_para2);
            _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
            _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
            if(_data.army.baseHero.vipType == 1)
            {
               _vipIcon.setFrame(1);
            }
            else
            {
               _vipIcon.setFrame(2);
            }
            if(_data.army.baseHero.IsVipAndNoExpirt)
            {
               addChild(_vipnameTxt);
               addChild(_vipIcon);
               if(_vipnameTxt.textWidth + 3 > 141)
               {
                  _loc2_ = int(_vipnameTxt.getCharIndexAtPoint(116,5));
                  _vipnameTxt.text = _vipnameTxt.text.substring(0,_loc2_) + "...";
               }
            }
            else
            {
               addChild(_para2);
            }
         }
         else
         {
            _para1.text = "";
            _para2.text = "";
            _vipnameTxt.text = "";
            _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
            _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
            _para3.text = "";
            _para4.text = "";
            _para5.text = "";
            _para6.text = "";
            _serverName.text = "";
            _levleHbox.visible = false;
            _levelIcon.visible = false;
            _petName.text = "";
         }
      }
      
      private function showTipButton() : void
      {
      }
      
      private function refreshView() : void
      {
         var _loc1_:TextFormat = null;
         var _loc2_:int = 0;
         _serverName.visible = false;
         _petName.text = "";
         _vipIcon.x = 82;
         _para4.width = 100;
         refreshVocation();
         if(_data)
         {
            _levleHbox.x = 333;
            _para2.x = 88;
            _para3.x = 26;
            _para1.text = _data.orderId.toString();
            switch(int(_model.currentSelected) - 1)
            {
               case 0:
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 232;
                  _para4.x = 415;
                  _para4.width = 130;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para3.text = _data.grades.toString();
                  _para4.text = _data.gp.toString();
                  break;
               case 1:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para4.width = 130;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.fightCapacity.toString();
                  break;
               case 2:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.multipleCapacity.toString();
                  break;
               case 3:
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _para5.visible = false;
                  _para6.visible = false;
                  _para4.x = 386;
                  _para4.width = 130;
                  _levleHbox.x = 272;
                  _para2.text = _data.consortiaName;
                  _para3.text = _data.consortiaLevel.toString();
                  _para4.text = _data.consortiaFightPower.toString();
                  break;
               case 4:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = true;
                  _para5.x = 233;
                  _para4.x = 284;
                  _para4.width = 165;
                  _para6.x = 430;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _model.getHonourName(_data.selfHonour);
                  _para6.text = _data.selfHonour.toString();
                  break;
               case 5:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para4.width = 130;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.charms.toString();
                  break;
               case 6:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para4.width = 130;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.soulScore.toString();
                  break;
               case 8:
                  _para5.visible = true;
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _petName.text = _data.petData.name;
                  _petName.setFrame(_data.petData.quality);
                  _loc1_ = _petName.getTextFormat();
                  _loc1_.align = "center";
                  _petName.setTextFormat(_loc1_);
                  _para5.text = _data.petData.petTypeLanguage;
                  _para2.text = _data.nikcName;
                  _para3.text = _data.petData.grade + "";
                  _para4.text = _data.petData.fightPower + "";
                  _petName.x = 15;
                  _para2.x = 233;
                  _para5.x = 157;
                  _para5.width = 86;
                  _levleHbox.x = 360;
                  _para4.x = 420;
                  _para4.width = 130;
                  _vipIcon.x = 238;
                  break;
               case 11:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para4.width = 140;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = _data.regressTime;
                  break;
               case 12:
                  _para5.visible = false;
                  _levleHbox.visible = true;
                  _levelIcon.visible = true;
                  _levelIcon.visible = false;
                  _para1.x = -15;
                  _petName.text = _data.childData.name;
                  _petName.setFrame(7);
                  _loc1_ = _petName.getTextFormat();
                  _loc1_.align = "center";
                  _petName.setTextFormat(_loc1_);
                  _para2.text = _data.nikcName;
                  _para3.width = 151;
                  _para3.x = 16;
                  _para3.text = ChildManager.instance.getJobName(_data.childData.job);
                  _para4.text = _data.childData.fightValue + "";
                  _petName.width = 195;
                  _petName.x = 35;
                  _para2.x = 190;
                  _levleHbox.x = 295;
                  _para4.x = 450;
                  _vipIcon.x = 238;
                  break;
               case 13:
                  _levleHbox.visible = false;
                  _levelIcon.visible = false;
                  _para5.visible = true;
                  _para6.visible = false;
                  _para5.x = 265;
                  _para4.x = 390;
                  _para2.text = _data.nikcName;
                  _para5.text = JobType.getJobName(_data.army.baseHero.templateInfo.Job);
                  _para4.text = "" + _data.army.baseHero.theseusInfo.propertys.armour;
            }
            _vipnameTxt.x = _para2.x;
            _vipnameTxt.y = _para2.y;
            _vipnameTxt.text = _para2.text;
            _vipIcon.y = _vipnameTxt.y + 2;
            _para2.parent && _para2.parent.removeChild(_para2);
            _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
            _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
            if(_data.army.baseHero.vipType == 1)
            {
               _vipIcon.setFrame(1);
            }
            else
            {
               _vipIcon.setFrame(2);
            }
            if(_data.army.baseHero.IsVipAndNoExpirt)
            {
               addChild(_vipnameTxt);
               addChild(_vipIcon);
               if(_vipnameTxt.textWidth + 3 > 141)
               {
                  _loc2_ = int(_vipnameTxt.getCharIndexAtPoint(113,5));
                  _vipnameTxt.text = _vipnameTxt.text.substring(0,_loc2_) + "...";
               }
            }
            else
            {
               addChild(_para2);
            }
         }
         else
         {
            _para1.text = "";
            _para2.text = "";
            _vipnameTxt.text = "";
            _vipnameTxt.parent && _vipnameTxt.parent.removeChild(_vipnameTxt);
            _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
            _para3.text = "";
            _para4.text = "";
            _para5.text = "";
            _para6.text = "";
            _levleHbox.visible = false;
            _levelIcon.visible = false;
            _petName.text = "";
         }
      }
   }
}

