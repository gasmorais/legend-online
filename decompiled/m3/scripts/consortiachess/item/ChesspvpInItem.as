package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ChesspvpInItem extends Sprite
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _roleCom:ChesspvpRoleComItem;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _canEdit:Boolean = false;
      
      public function ChesspvpInItem(param1:Boolean)
      {
         super();
         _canEdit = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRitemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRitemName");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRitemJob");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRitemLv");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRitemFight");
         _roleCom = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.ChesspvpRoleComItem",[_canEdit]);
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_jobTxt);
         addChild(_gradeTxt);
         addChild(_fightTxt);
         addChild(_roleCom);
      }
      
      public function initThane(param1:ThaneInfo) : void
      {
         _nameTxt.text = param1.nickName;
         _jobTxt.text = JobType.getJobName(param1.templateInfo.Job);
         _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",param1.grades);
         _fightTxt.text = param1.fightingCapacity.toString();
         _roleCom.data = param1;
      }
      
      public function updateRole(param1:int) : void
      {
         _roleCom.updateRole(param1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_roleCom);
         _roleCom = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

