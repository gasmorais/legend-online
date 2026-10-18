package com.map.vehicle.view.tips
{
   import com.map.vehicle.data.VehicleBufferDamageInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.view.tips.BaseTip;
   
   public class VehicleBuffTip extends BaseTip
   {
      
      private var _nameSprite:Sprite;
      
      private var _totalBox:VBox;
      
      private var _injuryTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _castTime:FilterFrameText;
      
      private var _coolDown:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      public function VehicleBuffTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
         _injuryTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
         _injuryTxt.x = -30;
         _castTime = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _coolDown = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.DescTxt");
         _nameSprite = new Sprite();
         _bg.width = 195;
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:VehicleSkillTempInfo = null;
         var _loc2_:VehicleBufferDamageInfo = null;
         var _loc1_:VehicleSkillBuffTemplate = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
         _totalBox.removeAllChild();
         super.updateTransform();
         if(tipData)
         {
            if(tipData is VehicleSkillTempInfo)
            {
               _loc3_ = tipData as VehicleSkillTempInfo;
               _nameTxt.text = _loc3_.TemplateName;
               _injuryTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + _loc3_.InjuryEffect);
               _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.castTime",_loc3_.CastTime / 1000);
               _coolDown.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown / 1000);
               _descTxt.htmlText = _loc3_.Description;
               _nameSprite.addChild(_nameTxt);
               _nameSprite.addChild(_injuryTxt);
               _totalBox.addChild(_nameSprite);
               if(_loc3_.InjuryEffect == 3)
               {
                  _totalBox.addChild(_descTxt);
               }
               else
               {
                  _totalBox.addChild(_castTime);
                  _totalBox.addChild(_coolDown);
                  _totalBox.addChild(_descTxt);
               }
            }
            else if(tipData is VehicleBufferDamageInfo)
            {
               _loc2_ = tipData as VehicleBufferDamageInfo;
               _loc1_ = _loc2_.buffTemplate;
               _nameTxt.text = _loc1_.Name;
               _descTxt.htmlText = _loc1_.Description;
               _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",int(_loc1_.Duration / 1000));
               _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",_loc2_.leftTime) + LanguageMgr.GetTranslation("public.time.second");
               _timer = new Timer(1000);
               _timer.start();
               _timer.addEventListener("timer",__onTimerHandler);
               _totalBox.addChild(_nameTxt);
               _totalBox.addChild(_castTime);
               _totalBox.addChild(_coolDown);
               _totalBox.addChild(_descTxt);
            }
            _totalBox.refreshChildPos();
            _bg.height = _descTxt.y + _descTxt.textHeight + 20;
            _bg.width = _totalBox.width + 10;
         }
      }
      
      private function __onTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:VehicleBufferDamageInfo = null;
         if(tipData)
         {
            _loc2_ = tipData as VehicleBufferDamageInfo;
            if(_coolDown)
            {
               _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",_loc2_.leftTime) + LanguageMgr.GetTranslation("public.time.second");
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHandler);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _nameTxt = null;
         _descTxt = null;
         _injuryTxt = null;
         _nameSprite = null;
         _castTime = null;
         _coolDown = null;
         super.dispose();
      }
   }
}

