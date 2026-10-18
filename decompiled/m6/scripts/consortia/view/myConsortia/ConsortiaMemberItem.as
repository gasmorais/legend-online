package consortia.view.myConsortia
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaDutyLevel;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.view.community.ConsortiaPlayerMenu;
   
   public class ConsortiaMemberItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _nameTxt:FilterFrameText;
      
      private var _positionTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _apTxt:FilterFrameText;
      
      private var _offlineTimeTxt:FilterFrameText;
      
      private var _colorBg:ScaleFrameImage;
      
      private var _data:ThaneInfo;
      
      private var _menu:ConsortiaPlayerMenu;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vipText:GradientText;
      
      private var _itemLineImg:MutipleImage;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _hitSprite:Sprite;
      
      public function ConsortiaMemberItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemNameTextStyle");
         _positionTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemPositionTextStyle");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemJobTextStyle");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemGradeTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemContributeTextStyle");
         _apTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemAPTextStyle");
         _offlineTimeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemOfflineTimeTextStyle");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemNameGradientText");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("consortia.VocationIcon");
         _itemLineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.MemberItemLine");
         _vocationIcon.visible = false;
         _colorBg.setFrame(1);
         addChild(_colorBg);
         addChild(_nameTxt);
         addChild(_positionTxt);
         addChild(_jobTxt);
         addChild(_gradeTxt);
         addChild(_contributeTxt);
         addChild(_apTxt);
         addChild(_offlineTimeTxt);
         addChild(_vipText);
         addChild(_vipIcon);
         addChild(_itemLineImg);
         _hitSprite = new Sprite();
         hitArea = _hitSprite;
         addChild(_hitSprite);
         addChild(_vocationIcon);
      }
      
      private function setHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(8,0,865,29);
         _hitSprite.graphics.endFill();
         _hitSprite.y = 1;
         _hitSprite.x = 10;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_colorBg);
         ObjectUtils.disposeObject(_nameTxt);
         ObjectUtils.disposeObject(_positionTxt);
         ObjectUtils.disposeObject(_jobTxt);
         ObjectUtils.disposeObject(_gradeTxt);
         ObjectUtils.disposeObject(_contributeTxt);
         ObjectUtils.disposeObject(_apTxt);
         ObjectUtils.disposeObject(_offlineTimeTxt);
         ObjectUtils.disposeObject(_menu);
         ObjectUtils.disposeObject(_vipIcon);
         ObjectUtils.disposeObject(_vipText);
         ObjectUtils.disposeObject(_vocationIcon);
         ObjectUtils.disposeObject(_itemLineImg);
         if(_hitSprite)
         {
            _hitSprite.graphics.clear();
            if(_hitSprite.parent)
            {
               _hitSprite.parent.removeChild(_hitSprite);
            }
            _hitSprite = null;
         }
         _itemLineImg = null;
         _colorBg = null;
         _nameTxt = null;
         _positionTxt = null;
         _jobTxt = null;
         _gradeTxt = null;
         _contributeTxt = null;
         _apTxt = null;
         _offlineTimeTxt = null;
         _data = null;
         _menu = null;
         _vipIcon = null;
         _vipText = null;
         _vocationIcon = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         _data.addEventListener("CONSORTIA_DUTY_CHANGE",__onDutyUpdata);
         _data.addEventListener("UPDE_MEMEBER_STATE",__onStageUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         if(_data)
         {
            _data.removeEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
            _data.removeEventListener("CONSORTIA_DUTY_CHANGE",__onDutyUpdata);
            _data.removeEventListener("UPDE_MEMEBER_STATE",__onStageUpdata);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         removeEvent();
         _data = param1;
         setHitArea();
         if(_data && _data.templateInfo)
         {
            addEvent();
            _nameTxt.text = _data.nickName;
            _positionTxt.text = ConsortiaDutyLevel.getDutyByButyLevel(_data.dutyId);
            _jobTxt.text = JobType.getJobName(_data.templateInfo.Job);
            _contributeTxt.text = _data.consortiaOffer.toString() + " / " + _data.consortiaTotalOffer.toString();
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
            _apTxt.text = _data.fightingCapacity.toString();
            _offlineTimeTxt.text = getDate();
            if(isVip)
            {
               _nameTxt.visible = false;
               _vipText.visible = true;
               _vipText.text = _nameTxt.text;
               _vipIcon.visible = true;
               _vipIcon.x = 31;
               _vipIcon.y = _nameTxt.y + 3;
               if(_data.vipType == 1)
               {
                  _vipIcon.setFrame(1);
               }
               else
               {
                  _vipIcon.setFrame(2);
               }
            }
            else
            {
               if(_vipText)
               {
                  _vipText.visible = false;
               }
               if(_vipIcon)
               {
                  _vipIcon.visible = false;
               }
               _nameTxt.visible = true;
            }
            if(_data.userId == playerInfo.userId)
            {
               _data.addEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
               if(playerInfo.consortiaOffer > _data.consortiaTotalOffer)
               {
                  _contributeTxt.text = playerInfo.consortiaOffer + " / " + playerInfo.consortiaOffer;
               }
               else
               {
                  _contributeTxt.text = playerInfo.consortiaOffer + " / " + _data.consortiaTotalOffer;
               }
            }
         }
         else
         {
            buttonMode = false;
            _nameTxt.text = "";
            if(_vipText)
            {
               _vipText.text = "";
            }
            if(_vipIcon)
            {
               _vipIcon.visible = false;
            }
            _positionTxt.text = "";
            _jobTxt.text = "";
            _contributeTxt.text = "";
            _gradeTxt.text = "";
            _apTxt.text = "";
            _offlineTimeTxt.text = "";
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      private function get isVip() : Boolean
      {
         return _data.IsVipAndNoExpirt;
      }
      
      private function __onClickHandler(param1:Event) : void
      {
         if(!_data || _data.userId == playerInfo.userId)
         {
            return;
         }
         _menu = new ConsortiaPlayerMenu();
         _menu.x = StageReferance.stage.mouseX;
         var _loc2_:Point = localToGlobal(new Point(0,height));
         _menu.y = _loc2_.y - 10;
         _menu.closeRights = false;
         _menu.setData(_data);
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __onStageUpdata(param1:Event) : void
      {
         _offlineTimeTxt.text = getDate();
      }
      
      private function __onDutyUpdata(param1:Event) : void
      {
         _positionTxt.text = ConsortiaDutyLevel.getDutyByButyLevel(_data.dutyId);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onContributeUpdata(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaOffer > _data.consortiaTotalOffer)
         {
            _contributeTxt.text = playerInfo.consortiaOffer + "/" + playerInfo.consortiaOffer;
         }
         else
         {
            _contributeTxt.text = playerInfo.consortiaOffer + "/" + _data.consortiaTotalOffer;
         }
      }
      
      private function getDate() : String
      {
         var _loc11_:* = null;
         var _loc6_:* = null;
         var _loc1_:Date = null;
         var _loc5_:* = null;
         var _loc8_:Number = NaN;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         if(_data)
         {
            if(_data.right == 3)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.RightTip");
            }
            if(_data.isOnline)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.StateTip");
            }
            _loc1_ = new Date();
            _loc1_.time = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            if((_data.logOutTime as Date).time == 946656000000)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.dayTip",1);
            }
            _loc8_ = _loc1_.time - (_data.logOutTime as Date).time;
            _loc4_ = _loc8_ / 1000 / 3600;
            _loc10_ = _loc4_ / 24;
            if(_loc4_ <= 0)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.inHourTip");
            }
            if(_loc4_ < 24)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.hourTip",_loc4_);
            }
            if(_loc10_ < 30)
            {
               return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.dayTip",_loc10_);
            }
            return LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaMemberItem.longTip");
         }
         return "";
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected && _data)
         {
            _colorBg.setFrame(2);
         }
         else
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

