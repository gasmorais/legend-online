package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildNsBuffShowSkView extends Sprite
   {
      
      private var _skIconBg:Bitmap;
      
      private var _skIcon:BaseIconView;
      
      private var _skNameTxt:FilterFrameText;
      
      private var _cdTxt:FilterFrameText;
      
      private var _desTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _data:SkillTempInfo;
      
      public function ChildNsBuffShowSkView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _skIconBg = ComponentFactory.Instance.creatBitmap("asset.ChildNSSkillItemView.back1");
         _skIcon = ComponentFactory.Instance.creatCustomObject("ChildNSSkillItemView.skillItem");
         _skNameTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.skNameTxt");
         _cdTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.cdTxt");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.skDesTxt");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNsBuffShowSkView.tipTxt");
         addChild(_skIconBg);
         addChild(_skIcon);
         addChild(_skNameTxt);
         addChild(_cdTxt);
         addChild(_desTxt);
         addChild(_tipTxt);
      }
      
      public function showIdx(param1:int, param2:ChildData) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc7_:SkillTempInfo = null;
         var _loc6_:int = 0;
         var _loc5_:String = param2.fightSkill;
         if(_loc5_)
         {
            _loc3_ = _loc5_.split(",");
         }
         if(_loc3_ && _loc3_[param1] && _loc3_[param1] != "-1")
         {
            _loc4_ = param2.skill.split(",");
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               if(_loc4_[_loc6_] && parseInt(_loc4_[_loc6_]) > 0)
               {
                  if(TempleteManager.instance.getSkillById(_loc4_[_loc6_]).SonType == _loc3_[param1])
                  {
                     _loc7_ = TempleteManager.instance.getSkillById(_loc4_[_loc6_]);
                  }
               }
               _loc6_++;
            }
            data = _loc7_;
         }
         else
         {
            _tipTxt.text = LanguageMgr.GetTranslation("childnsbuffShow.tip");
         }
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _skIcon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _skNameTxt.htmlText = _data.TemplateName;
            if(_data.CoolDown > 0)
            {
               _cdTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_data.CoolDown * 0.001);
            }
            _desTxt.text = _data.Description;
            _tipTxt.text = "";
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_skIconBg);
         _skIconBg = null;
         ObjectUtils.disposeObject(_skIcon);
         _skIcon = null;
         ObjectUtils.disposeObject(_skNameTxt);
         _skNameTxt = null;
         ObjectUtils.disposeObject(_cdTxt);
         _cdTxt = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

