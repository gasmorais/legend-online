package goddess.view
{
   import avatar.load.ShowAvatarLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.FlickerHelper;
   
   public class GoddessAvaterView extends Component
   {
      
      private var _avater:ShowAvatarLoader;
      
      private var _avaterBg:Bitmap;
      
      private var _nikeBack:Bitmap;
      
      private var _avaterNameTxt:FilterFrameText;
      
      private var _avaterLvTxt:FilterFrameText;
      
      private var _starHbox:HBox;
      
      private var _data:GoddessInfo;
      
      private var _fightBtn:SelectedButton;
      
      private var _hitSp:Sprite;
      
      private var _viewType:int;
      
      private var _isEquip:Boolean;
      
      public function GoddessAvaterView(param1:int = 1)
      {
         super();
         _viewType = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _avaterBg = ComponentFactory.Instance.creatBitmap("asset.goddess.roleBg");
         _nikeBack = ComponentFactory.Instance.creatBitmap("asset.goddess.nikeBack");
         _avaterNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.avaterNickTxt");
         _avaterLvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.avaterLvTxt");
         _starHbox = ComponentFactory.Instance.creatCustomObject("ui.goddess.avaterStarbox");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.fightBtn");
         _hitSp = new Sprite();
         _avater = new ShowAvatarLoader(null);
         addChild(_avaterBg);
         addChild(_avater);
         addChild(_nikeBack);
         addChild(_avaterNameTxt);
         addChild(_avaterLvTxt);
         addChild(_starHbox);
         addChild(_fightBtn);
         _avater.x = 263;
         _avater.y = 60;
         _hitSp.x = 263;
         _hitSp.y = 60;
         _avater.mouseChildren = _avater.mouseEnabled = false;
         _hitSp.graphics.beginFill(16711680,1);
         _hitSp.graphics.drawRect(0,0,378,465);
         _hitSp.graphics.endFill();
         _fightBtn.visible = false;
         this.hitArea = _hitSp;
      }
      
      private function initEvent() : void
      {
         _fightBtn.addEventListener("click",clickFightHandler);
      }
      
      private function removeEvent() : void
      {
         if(_fightBtn)
         {
            _fightBtn.removeEventListener("click",clickFightHandler);
         }
      }
      
      private function clickFightHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         FlickerHelper.clearFilcker(_fightBtn);
         GodDessManager.instance.requestOp(5,_data.templateId,0,!_data.isFight);
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_avater);
         _avater = null;
         ObjectUtils.disposeObject(_avaterBg);
         _avaterBg = null;
         ObjectUtils.disposeObject(_avaterNameTxt);
         _avaterNameTxt = null;
         ObjectUtils.disposeObject(_avaterLvTxt);
         _avaterLvTxt = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_nikeBack);
         _nikeBack = null;
         if(_fightBtn)
         {
            FlickerHelper.clearFilcker(_fightBtn);
         }
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_hitSp);
         _hitSp = null;
         super.dispose();
         _data = null;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         _isEquip = param1;
         if(_isEquip)
         {
            _avaterNameTxt.visible = false;
            _avaterLvTxt.visible = false;
            _starHbox.visible = false;
            _fightBtn.visible = false;
            _nikeBack.visible = false;
         }
         else
         {
            _avaterNameTxt.visible = true;
            _avaterLvTxt.visible = true;
            _starHbox.visible = true;
            _fightBtn.visible = _viewType != 2;
            _nikeBack.visible = true;
         }
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         _data = param1;
         refreshView();
         this.isEquip = _isEquip;
      }
      
      private function refreshView() : void
      {
         var _loc2_:GoddessAdvaceTempInfo = null;
         var _loc1_:String = null;
         if(_data == null)
         {
            _avaterNameTxt.visible = false;
            _avater.visible = false;
            _avaterLvTxt.visible = false;
            _fightBtn.visible = false;
            _avater.initPath(null);
         }
         else
         {
            _avaterNameTxt.visible = true;
            _avaterLvTxt.visible = true;
            _avater.visible = true;
            _fightBtn.visible = _data.isActive;
            level = _data.grade;
            quality = _data.advanceTempInfo.Quality;
            if(_data.isActive)
            {
               star = _data.advanceTempInfo.Star;
               _fightBtn.selected = _data.isFight;
            }
            else
            {
               level = _data.tempInfo.MaxGrade;
               _loc2_ = TempleteManager.instance.goddessAdvanceTempCate.getTemplete(_data.tempInfo.Type,_data.tempInfo.MaxStep);
               if(_loc2_)
               {
                  star = _loc2_.Star;
                  quality = _loc2_.Quality;
               }
            }
            _loc1_ = PathManager.getGoddessAvaterPath(_data.tempInfo.Resource);
            _avater.initPath(_loc1_);
         }
         if(_viewType == 2)
         {
            _fightBtn.visible = false;
         }
      }
      
      public function levelChange(param1:GoddessInfo) : void
      {
         if(_data == param1 && param1 != null)
         {
            level = _data.grade;
         }
      }
      
      public function stepChange(param1:GoddessInfo) : void
      {
         if(_data == param1 && param1 != null)
         {
            star = _data.advanceTempInfo.Star;
            quality = _data.advanceTempInfo.Quality;
         }
      }
      
      public function set flashBtn(param1:Boolean) : void
      {
         if(_fightBtn == null)
         {
            return;
         }
         if(param1)
         {
            FlickerHelper.setFilckerSelf(_fightBtn);
         }
         else
         {
            FlickerHelper.clearFilcker(_fightBtn);
         }
      }
      
      private function set level(param1:int) : void
      {
         _avaterNameTxt.text = _data.tempInfo.TemplateName.replace("\n","");
         _avaterLvTxt.text = LanguageMgr.GetTranslation("public.level2",param1);
         _avaterNameTxt.x = 266 + (375 - (_avaterNameTxt.textWidth + _avaterLvTxt.textWidth + 10)) * 0.5;
         _avaterLvTxt.x = _avaterNameTxt.x + _avaterNameTxt.textWidth + 10;
      }
      
      private function set quality(param1:int) : void
      {
         _avaterNameTxt.setFrame(param1);
         _avaterLvTxt.setFrame(param1);
      }
      
      private function set star(param1:int) : void
      {
         var _loc2_:int = 0;
         ObjectUtils.disposeAllChildren(_starHbox);
         _starHbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            _starHbox.addChild(ComponentFactory.Instance.creatBitmap("asset.goddess.starImg"));
            _loc2_++;
         }
         _starHbox.commitChanges();
      }
   }
}

