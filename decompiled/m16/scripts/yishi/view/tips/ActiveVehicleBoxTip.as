package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import map.campaign.data.skill.MapBuffHurtData;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   
   public class ActiveVehicleBoxTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _timer:Timer;
      
      public function ActiveVehicleBoxTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         _bg.width = 255;
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         var _nameSprite:Sprite;
         var _injuryTxt:FilterFrameText;
         var _nameTxt:FilterFrameText;
         var _castTime:FilterFrameText;
         var _coolDown:FilterFrameText;
         var _descTxt:FilterFrameText;
         var _line:ScaleBitmapImage;
         var showTipsAry:Array;
         var tempInfo:Object;
         var info:VehicleSkillTempInfo;
         var buff:VehicleSkillBuffTemplate;
         var buffHurt:MapBuffHurtData;
         var buffTemp:VehicleSkillBuffTemplate;
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
            showTipsAry = tipData as Array;
            for each(tempInfo in showTipsAry)
            {
               _nameSprite = new Component();
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
               _injuryTxt = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
               _castTime = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
               _coolDown = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
               _descTxt = ComponentFactory.Instance.creatComponentByStylename("ActiveVehicleBoxTip.DescTxt");
               _line = ComponentFactory.Instance.creatComponentByStylename("DaimonSkillTip.line");
               if(tempInfo is VehicleSkillTempInfo)
               {
                  info = tempInfo as VehicleSkillTempInfo;
                  _nameTxt.text = info.TemplateName;
                  _injuryTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + info.InjuryEffect);
                  _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.castTime",info.CastTime / 1000);
                  _coolDown.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",info.CoolDown / 1000);
                  _descTxt.htmlText = info.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  _nameSprite.addChild(_nameTxt);
                  _nameSprite.addChild(_injuryTxt);
                  _totalBox.addChild(_nameSprite);
                  if(info.InjuryEffect == 3)
                  {
                     _totalBox.addChild(_descTxt);
                  }
                  else
                  {
                     _totalBox.addChild(_castTime);
                     _totalBox.addChild(_coolDown);
                     _totalBox.addChild(_descTxt);
                  }
                  _totalBox.addChild(_line);
               }
               else if(tempInfo is VehicleSkillBuffTemplate)
               {
                  buff = tempInfo as VehicleSkillBuffTemplate;
                  _nameTxt.text = buff.Name;
                  _descTxt.htmlText = buff.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  if(buff.Duration == -1)
                  {
                     _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.lastTime2",LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.Long"));
                     _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.Long"));
                  }
                  else
                  {
                     _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",int(buff.Duration / 1000));
                     _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + LanguageMgr.GetTranslation("public.time.second");
                  }
                  _totalBox.addChild(_nameTxt);
                  _totalBox.addChild(_castTime);
                  _totalBox.addChild(_coolDown);
                  _totalBox.addChild(_descTxt);
                  _totalBox.addChild(_line);
               }
               else if(tempInfo is MapBuffHurtData)
               {
                  buffHurt = tempInfo as MapBuffHurtData;
                  buffTemp = buffHurt.buffTemplate;
                  _nameTxt.text = buffTemp.Name;
                  _descTxt.htmlText = buffTemp.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  _totalBox.addChild(_nameTxt);
                  if(buffTemp.Duration != -1)
                  {
                     _castTime.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",int(buffTemp.Duration / 1000));
                     _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + LanguageMgr.GetTranslation("public.time.second");
                     _timer = new Timer(1000);
                     _timer.start();
                     _timer.addEventListener("timer",function(param1:TimerEvent):void
                     {
                        if(_coolDown)
                        {
                           _coolDown.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + LanguageMgr.GetTranslation("public.time.second");
                        }
                     });
                     _totalBox.addChild(_castTime);
                     _totalBox.addChild(_coolDown);
                  }
                  _totalBox.addChild(_descTxt);
                  _totalBox.addChild(_line);
               }
            }
            _totalBox.refreshChildPos();
            _bg.height = _totalBox.height + 10;
         }
      }
      
      private function __onTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:Object = null;
         if(tipData)
         {
            _loc2_ = tipData;
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
         super.dispose();
      }
   }
}

