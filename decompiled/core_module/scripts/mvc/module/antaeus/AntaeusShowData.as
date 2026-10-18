package mvc.module.antaeus
{
   import com.road.yishi.proto.antaeus.ArtifactShowMsg;
   import com.road.yishi.proto.antaeus.AssistantDataMsg;
   import com.road.yishi.proto.antaeus.AssistantPlayerShowMsg;
   import com.road.yishi.proto.antaeus.ChildrenShowMsg;
   import com.road.yishi.proto.antaeus.GoddessShowMsg;
   import com.road.yishi.proto.antaeus.PetShowMsg;
   import com.road.yishi.proto.antaeus.SlaveChildShowMsg;
   import com.road.yishi.proto.antaeus.TitanShowMsg;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class AntaeusShowData
   {
      
      public var player:AssistantPlayerShowMsg;
      
      public var pet:PetShowMsg;
      
      public var children:ChildrenShowMsg;
      
      public var slaveChild:SlaveChildShowMsg;
      
      public var artifact:ArtifactShowMsg;
      
      public var goddess:GoddessShowMsg;
      
      public var titan:TitanShowMsg;
      
      public function AntaeusShowData(param1:AssistantDataMsg)
      {
         super();
         player = param1.player;
         pet = param1.pet;
         children = param1.children;
         slaveChild = param1.slaveChild;
         artifact = param1.artifact;
         goddess = param1.goddess;
         titan = param1.titan;
      }
      
      public function get ICON() : String
      {
         return PathManager.info.ResourcePath + "icon";
      }
      
      public function getPetIcon() : String
      {
         return IconFactory.getPetHeadItemIcon(pet.templateId);
      }
      
      public function getChildIcon() : String
      {
         return ICON + TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(children.templateId,1).Icon;
      }
      
      public function getSlaveChildIcon() : String
      {
         return ICON + TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(slaveChild.templateId,1).Icon;
      }
      
      public function getGoddessIcon() : String
      {
         return PathManager.getGoddessSmallIcon(goddess.templateId);
      }
      
      public function getArtifactIcon() : String
      {
         return IconFactory.getCommonIconPath(TempleteManager.instance.artifactTemplateCate.getTemplateById(artifact.templateId).Icon);
      }
      
      public function getTitanIcon() : String
      {
         return IconFactory.getCommonIconPath(TempleteManager.instance.titanTemplateCate.getTemplateById(titan.templateId).AvatarPath);
      }
   }
}

