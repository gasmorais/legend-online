package yishi.datas.playerinfo
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import mvc.module.kingcontract.KingContractInfo;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.TempleteManager;
   import yishi.timer.TimerTicker;
   
   public class PlayerBufferInfo extends EventDispatcher
   {
      
      public static const BUFFER_MASTERTYPE_KING_CROSS_GUILD:int = 1000;
      
      public var templateId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      public var bufferType:int;
      
      public var masterType:int;
      
      private var _leftTime:Number;
      
      public var lastCount:int;
      
      public var rateCount:Number;
      
      public var grade:int;
      
      public var goodsTemplateId:int;
      
      public var addCount:int;
      
      private var _time:TimerTicker;
      
      public function PlayerBufferInfo()
      {
         super();
         _time = new TimerTicker(1000);
         _time.addEventListener("timer",__timerHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _leftTime = _leftTime - 1;
         dispatchEvent(new Event("change"));
         if(_leftTime == 0)
         {
            dispatchEvent(new Event("complete"));
            _time.stop();
         }
      }
      
      public function set leftTime(param1:Number) : void
      {
         _leftTime = param1;
         if(_leftTime > 0)
         {
            _time.start();
         }
         else
         {
            _time.stop();
         }
      }
      
      public function get leftTime() : Number
      {
         return _leftTime;
      }
      
      public function get icon() : String
      {
         if(bufferType == -1)
         {
            return "/serverEXP.png";
         }
         if(bufferType == -3)
         {
            return "/LordBless.png";
         }
         if(bufferType == -2)
         {
            return "/exclusiveBuff.png";
         }
         if(bufferType == 2)
         {
            return getGoodsTemplate().Icon;
         }
         if(bufferType == -4)
         {
            return "/petfight0" + masterType + ".png";
         }
         if(bufferType == 20000)
         {
            return "/exclusiveBuff.png";
         }
         if(bufferType == -5)
         {
            return "/TitanBless.png";
         }
         if(bufferType == 7)
         {
            return (template as SkillTempInfo).Icons;
         }
         if(bufferType == 40004)
         {
            return "/item_give_thedevil.png";
         }
         if(bufferType == 40005)
         {
            return "/ragnarok_rubbish.png";
         }
         if(bufferType == 40006)
         {
            return "/ragnarok_buff.png";
         }
         if(bufferType == 40007)
         {
            return "/magicspring/" + template.Icon;
         }
         if(bufferType == 8)
         {
            return "/antaeus.png";
         }
         return template.Icon;
      }
      
      public function get name() : String
      {
         if(bufferType == -1)
         {
            return LanguageMgr.GetTranslation("yishi.datas.playerinfo.PlayerBufferInfo.name",rateCount / 100);
         }
         if(bufferType == -3)
         {
            return _name;
         }
         if(bufferType == -5)
         {
            return _name;
         }
         if(bufferType == -2)
         {
            return KingTemplate.template.Name;
         }
         if(bufferType == 2)
         {
            return getGoodsTemplate().TemplateName;
         }
         if(bufferType == 4)
         {
            return template.EffectName;
         }
         if(bufferType == -4)
         {
            return LanguageMgr.GetTranslation("yishi.datas.playerinfo.PlayerBufferInfo.BasePropertyName" + masterType);
         }
         if(bufferType == 20000)
         {
            return LanguageMgr.GetTranslation("playerBufferInfo.fashionAddition");
         }
         if(bufferType == 7)
         {
            return (template as SkillTempInfo).TemplateName;
         }
         if(bufferType == 40004)
         {
            return LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.item4");
         }
         if(bufferType == 40005)
         {
            return _name;
         }
         if(bufferType == 40006)
         {
            return _name;
         }
         if(bufferType == 8)
         {
            return LanguageMgr.GetTranslation("antaeus.buff.name");
         }
         return template.TemplateName;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         var _loc1_:String = null;
         var _loc2_:PlayerBufferInfo = null;
         if(bufferType == -1)
         {
            return LanguageMgr.GetTranslation("yishi.datas.playerinfo.PlayerBufferInfo.description",rateCount);
         }
         if(bufferType == -3 || bufferType == -5 || bufferType == -4 || bufferType == 40005 || bufferType == 40006)
         {
            return _description;
         }
         if(bufferType == -2)
         {
            return KingTemplate.template.Description;
         }
         if(bufferType == 2 || bufferType == 4)
         {
            _loc1_ = template.Description;
            return _loc1_.replace("{Grades}",grade);
         }
         if(bufferType == 20000)
         {
            return _description;
         }
         if(bufferType == 7)
         {
            return (template as SkillTempInfo).Description;
         }
         if(bufferType == 40004)
         {
            return LanguageMgr.GetTranslation("map.campaign.view.ui.gvgcross.reward.des4");
         }
         if(templateId == 6001)
         {
            return LanguageMgr.GetTranslation("godsEvening.campaignBuffer.tip",addCount * (template as CampaignBufferTemp).Attack);
         }
         if(bufferType == 8)
         {
            _loc2_ = PlayerBufferManager.instance.getItemBufferInfoByType(8);
            if(_loc2_)
            {
               return LanguageMgr.GetTranslation("antaeus.tip.buff",LanguageMgr.GetTranslation("antaeus.campaign.str" + _loc2_.grade));
            }
         }
         else if(bufferType == 40007)
         {
            return template.Desc;
         }
         return template.Description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get template() : Object
      {
         if(bufferType == 2)
         {
            return TempleteManager.instance.effectTemplateCate.getTemplateByID(templateId);
         }
         if(bufferType == 4)
         {
            return TempleteManager.instance.effectTemplateCate.getTemplateByID(templateId);
         }
         if(bufferType == 7)
         {
            return TempleteManager.instance.getSkillTemplateInfoById(templateId);
         }
         if(bufferType == 40007)
         {
            return TempleteManager.instance.magicSpringTempCate.getTemplateById(templateId);
         }
         return TempleteManager.instance.campaignBufferTemplate.getTemplateByID(templateId);
      }
      
      public function getGoodsTemplate() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(goodsTemplateId);
      }
      
      public function get KingTemplate() : KingContractInfo
      {
         return KingContractManager.Instance.model.getInfoById(7);
      }
   }
}

