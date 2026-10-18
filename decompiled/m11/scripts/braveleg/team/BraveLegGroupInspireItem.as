package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.braveleg.BraveLegModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.BraveLegManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class BraveLegGroupInspireItem extends Component implements IListCell
   {
      
      private var _iconBg:Image;
      
      private var _bg:Image;
      
      private var _icon:BaseIconView;
      
      private var _numBg:Image;
      
      private var _numTxt:FilterFrameText;
      
      private var _btn:BaseButton;
      
      private var _data:Object;
      
      private var _model:BraveLegModel = BraveLegManager.instance.model;
      
      private var _hit:Sprite;
      
      public function BraveLegGroupInspireItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireIconBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireIcon");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireNumBg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireNumTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("braveleg.InspireBtn");
         var _loc2_:BitmapData = new BitmapData(_icon.iconWidth,_icon.iconHeight,true,16777215);
         _loc2_.floodFill(0,0,16777215);
         var _loc1_:Bitmap = new Bitmap(_loc2_);
         _hit = new Sprite();
         _hit.addChild(_loc1_);
         _hit.x = _icon.x;
         _hit.y = _icon.y;
         addChild(_iconBg);
         addChild(_bg);
         addChild(_icon);
         addChild(_numBg);
         addChild(_numTxt);
         addChild(_btn);
         addChild(_hit);
         _btn.supportTipsWhenGray = true;
      }
      
      private function addEvent() : void
      {
         _icon.addEventListener("mouseDown",__iconClickHandler);
         _hit.addEventListener("mouseDown",__iconClickHandler);
         _btn.addEventListener("click",__onClickBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _icon.removeEventListener("mouseDown",__iconClickHandler);
         _hit.removeEventListener("mouseDown",__iconClickHandler);
         _btn.removeEventListener("click",__onClickBtnHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_hit);
         _hit = null;
         _model = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc2_:SkillInfo = null;
         _data = param1;
         if(_data.masterType)
         {
            _numBg.visible = true;
            _numTxt.text = _data.grades - 1 + "";
            if(param1.isReady)
            {
               _btn.enable = true;
               _btn.tipData = LanguageMgr.GetTranslation("braveleg.Tip.inspire");
            }
            else
            {
               _btn.enable = false;
               _btn.tipData = LanguageMgr.GetTranslation("braveleg.Tip.inspireCD");
            }
            _loc3_ = TempleteManager.instance.getChildSkillsByMasterTypeAndGrades(_data.masterType,_data.grades)[0];
            _icon.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
            _loc2_ = new SkillInfo();
            _loc2_.templateId = _loc3_.TemplateId;
            _loc2_.grade = _data.grades;
            _icon.tipData = _loc2_;
            _icon.visible = true;
            _hit.visible = false;
         }
         else
         {
            _numBg.visible = false;
            _numTxt.text = "";
            _btn.enable = false;
            _btn.tipData = null;
            _icon.icon = null;
            _icon.tipData = null;
            _icon.visible = false;
            _hit.visible = true;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      private function __iconClickHandler(param1:MouseEvent) : void
      {
         if(!_model.teamInfo.isMaster)
         {
         }
      }
      
      private function __onClickBtnHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         if(_data && _data.count > 0)
         {
            if(TempleteManager.instance.getChildSkillsByMasterTypeAndGrades(_data.masterType,_data.grades + 1).length > 0)
            {
               _loc4_ = int(ConfigInfoManager.instance.getBraveLegInspireGold());
               if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _loc4_)
               {
                  RechargeAlertMannager.show();
               }
               else
               {
                  SimpleAlertHelper.instance.data = [conformInspire];
                  _loc2_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc3_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc5_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc6_ = LanguageMgr.GetTranslation("braveleg.Dialog.inspire",_loc4_);
                  SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_);
               }
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str09"));
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("braveleg.Error.str07"));
         }
      }
      
      private function conformInspire(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _data)
         {
            BraveLegManager.instance.requestInspireTeam(_data.groupId);
         }
      }
   }
}

