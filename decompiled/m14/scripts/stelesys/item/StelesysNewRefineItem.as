package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class StelesysNewRefineItem extends Sprite
   {
      
      protected var _protxt:FilterFrameText;
      
      protected var _mc:MovieClip;
      
      private var _skillId:int = -1;
      
      public function StelesysNewRefineItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _protxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineMItemNewTxt");
         _mc = ComponentFactory.Instance.creatCustomObject("asset.stelesys.newrefineMc");
         addChild(_protxt);
         addChild(_mc);
         _mc.mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_protxt);
         _protxt = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set skillId(param1:int) : void
      {
         var _loc3_:Boolean = _skillId == -1;
         if(_skillId == param1)
         {
            return;
         }
         _skillId = param1;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillById(_skillId);
         if(_loc2_)
         {
            _protxt.text = _loc2_.TemplateName;
         }
         if(!_loc3_)
         {
            _mc.gotoAndPlay(1);
         }
      }
   }
}

