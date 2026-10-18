package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class InlayItem extends Sprite implements Disposeable
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      public function InlayItem()
      {
         super();
         _icon = ComponentFactory.Instance.creatComponentByStylename("tips.MountIcon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodMountText");
         addChild(_icon);
         addChild(_txt);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         _icon.setFrame(param1 == -1 ? 9 : (param1 == 0 ? 10 : getColorByType(param1)));
         _txt.setFrame(param1 == -1 ? 1 : (param1 == 0 ? 2 : 3));
         _txt.htmlText = param1 == -1 ? LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value01") : (param1 == 0 ? LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value02") : getDiscription(param1,param2));
      }
      
      private function getDiscription(param1:int, param2:int) : String
      {
         var _loc4_:int = 0;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(!_loc3_)
         {
            return "";
         }
         if(param2 == thane.id)
         {
            _loc4_ = _loc3_.totalAttribute * GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades) / 100;
            if(thane.jewelGrades >= 80 && playerinfo.vocationGrades > 0)
            {
               _loc4_ = _loc3_.totalAttribute * GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade) / 100;
            }
            if(_loc4_ == 0)
            {
               return _loc3_.Description;
            }
            return _loc3_.Description + "<font color=\'#48d72a\'> +" + _loc4_ + "</font>";
         }
         return _loc3_.Description;
      }
      
      private function getColorByType(param1:int) : int
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         return _loc2_.Property1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_txt)
         {
            _txt.dispose();
         }
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

