﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Resources {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class ModelValidationResources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal ModelValidationResources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Resources.ModelValidationResources", typeof(ModelValidationResources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {0} must be between {1} and {2} characters long!.
        /// </summary>
        public static string InavlidInputLength {
            get {
                return ResourceManager.GetString("InavlidInputLength", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to A {0} with the {1} of &apos;{2}&apos; is already registered ({3}).
        /// </summary>
        public static string NonUniqueField {
            get {
                return ResourceManager.GetString("NonUniqueField", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to A {0} with the {1} of &apos;{2}&apos; is already registered.
        /// </summary>
        public static string NonUniqueField_NoReference {
            get {
                return ResourceManager.GetString("NonUniqueField_NoReference", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The {0} may only contain alpha-numeric characters, hyphens and underscores (a-z,-,_).
        /// </summary>
        public static string Reference_Regex {
            get {
                return ResourceManager.GetString("Reference_Regex", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to A {0} must be specified.
        /// </summary>
        public static string Required_General {
            get {
                return ResourceManager.GetString("Required_General", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to A unique {0} must be specified.
        /// </summary>
        public static string Required_Unique {
            get {
                return ResourceManager.GetString("Required_Unique", resourceCulture);
            }
        }
    }
}
